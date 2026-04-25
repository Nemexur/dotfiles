{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  which,
  rustPlatform,
  emscripten,
  openssl,
  pkg-config,
  substitute,
  installShellFiles,
  buildPackages,
  enableShared ? !stdenv.hostPlatform.isStatic,
  enableStatic ? stdenv.hostPlatform.isStatic,
  webUISupport ? false,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tree-sitter";
  version = "0.26.8";

  src = fetchFromGitHub {
    owner = "tree-sitter";
    repo = "tree-sitter";
    tag = "v${finalAttrs.version}";
    hash = "sha256-fcFEfoALrbpBD6rWogxJ7FNVlvDQgswoX9ylRgko+8Q=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-9FeWnWWPUWmMF15Psmul8GxGv2JceHWc2WZPmOr81gw=";

  buildInputs =
    [
      installShellFiles
    ]
    ++ lib.optionals webUISupport [
      openssl
    ];
  nativeBuildInputs =
    [
      rustPlatform.bindgenHook
      which
    ]
    ++ lib.optionals webUISupport [
      emscripten
      pkg-config
    ];

  patches = lib.optionals (!webUISupport) [
    (substitute {
      src = ./remove-web-interface.patch;
    })
    (fetchpatch {
      name = "feat: allow `-` in grammar names";
      url = "https://github.com/tree-sitter/tree-sitter/commit/7d3c32125379c1dc02f47277bcd4eceaac299bdb.diff";
      hash = "sha256-ZNjdNateHVHDy0/txlAW8TUdz+DVxLKXpw8ojZbIQS8=";
    })
  ];

  postPatch =
    lib.optionalString webUISupport ''
      substituteInPlace cli/loader/src/lib.rs \
          --replace-fail 'let emcc_name = if cfg!(windows) { "emcc.bat" } else { "emcc" };' 'let emcc_name = "${lib.getExe' emscripten "emcc"}";'
    ''
    # when building on static platforms:
    # 1. remove the `libtree-sitter.$(SOEXT)` step from `all`
    # 2. remove references to shared object files in the Makefile
    + lib.optionalString stdenv.hostPlatform.isStatic ''
      substituteInPlace ./Makefile \
          --replace-fail 'all: libtree-sitter.a libtree-sitter.$(SOEXT) tree-sitter.pc' 'all: libtree-sitter.a tree-sitter.pc'
      sed -i '/^install:/,/^[^[:space:]]/ { /$(SOEXT/d; }' ./Makefile
    '';

  # Compile web assembly with emscripten. The --debug flag prevents us from
  # minifying the JavaScript; passing it allows us to side-step more Node
  # JS dependencies for installation.
  preBuild = lib.optionalString webUISupport ''
    mkdir -p .emscriptencache
    export EM_CACHE=$(pwd)/.emscriptencache
    cargo run --package xtask -- build-wasm --debug
  '';

  postInstall =
    ''
      PREFIX=$out make install
      ${lib.optionalString (!enableShared) "rm -f $out/lib/*.so{,.*}"}
      ${lib.optionalString (!enableStatic) "rm -f $out/lib/*.a"}

      mv docs/src/assets/schemas/config.schema.json $out/
    ''
    + lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      installShellCompletion --cmd tree-sitter \
        --bash <("$out/bin/tree-sitter" complete --shell bash) \
        --zsh <("$out/bin/tree-sitter" complete --shell zsh) \
        --fish <("$out/bin/tree-sitter" complete --shell fish)
    ''
    + lib.optionalString (!stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      installShellCompletion --cmd tree-sitter \
        --bash "${buildPackages.tree-sitter}"/share/bash-completion/completions/*.bash \
        --zsh "${buildPackages.tree-sitter}"/share/zsh/site-functions/* \
        --fish "${buildPackages.tree-sitter}"/share/fish/*/*
    '';

  # test result: FAILED. 120 passed; 13 failed; 0 ignored; 0 measured; 0 filtered out
  doCheck = false;

  meta = {
    homepage = "https://github.com/tree-sitter/tree-sitter";
    description = "Parser generator tool and an incremental parsing library";
    mainProgram = "tree-sitter";
    changelog = "https://github.com/tree-sitter/tree-sitter/releases/tag/v${finalAttrs.version}";
    longDescription = ''
      Tree-sitter is a parser generator tool and an incremental parsing library.
      It can build a concrete syntax tree for a source file and efficiently update the syntax tree as the source file is edited.

      Tree-sitter aims to be:

      * General enough to parse any programming language
      * Fast enough to parse on every keystroke in a text editor
      * Robust enough to provide useful results even in the presence of syntax errors
      * Dependency-free so that the runtime library (which is written in pure C) can be embedded in any application
    '';
    license = lib.licenses.mit;
  };
})
