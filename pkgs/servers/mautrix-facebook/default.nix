{ enableSystemd ? stdenv.isLinux
, fetchFromGitHub
, lib
, python3
, stdenv
}:

python3.pkgs.buildPythonPackage rec {
  pname = "mautrix-facebook";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "mautrix";
    repo = "facebook";
    rev = "v${version}";
    sha256 = "1n7gshm2nir6vgjkj36lq9m2bclkgy0y236xi8zvdlvfcb2m596f";
  };

  propagatedBuildInputs = with python3.pkgs; [
    CommonMark
    aiohttp
    asyncpg
    mautrix
    paho-mqtt
    pillow
    prometheus-client
    pycryptodome
    python-olm
    python_magic
    ruamel-yaml
    unpaddedbase64
    yarl
  ] ++ lib.optional enableSystemd systemd;

  doCheck = false;

  postInstall = ''
    mkdir -p $out/bin

    cat <<-END >$out/bin/mautrix-facebook
    #!/bin/sh
    PYTHONPATH="$PYTHONPATH" exec ${python3}/bin/python -m mautrix_facebook "\$@"
    END
    chmod +x $out/bin/mautrix-facebook
  '';

  meta = with lib; {
    homepage = "https://github.com/mautrix/facebook";
    description = "A Matrix-Facebook Messenger puppeting bridge";
    license = licenses.agpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ kevincox ];
  };
}
