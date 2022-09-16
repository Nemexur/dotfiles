if [[ "${OSTYPE}" == "darwin"* ]]; then
    # xcode-select setup
    export GOROOT="/usr/local/opt/go/libexec"
elif [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    export GOROOT="/home/linuxbrew/.linuxbrew/opt/go/libexec"   
fi
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"
