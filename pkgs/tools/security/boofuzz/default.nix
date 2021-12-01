{ lib
, fetchFromGitHub
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "boofuzz";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "jtpereyda";
    repo = pname;
    rev = "v${version}";
    sha256 = "4WtTZ2S2rC2XXN0HbiEht9NW0JXcPnpp66AH67F88yk=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    attrs
    click
    colorama
    flask
    funcy
    future
    psutil
    pyserial
    pydot
    six
    tornado
  ];

  checkInputs = with python3.pkgs; [
    mock
    netifaces
    pytest-bdd
    pytestCheckHook
  ];

  disabledTests = [
    # Tests require socket access
    "test_raw_l2"
    "test_raw_l3"
  ];

  pythonImportsCheck = [
    "boofuzz"
  ];

  meta = with lib; {
    description = "Network protocol fuzzing tool";
    homepage = "https://github.com/jtpereyda/boofuzz";
    license = with licenses; [ gpl2Plus ];
    maintainers = with maintainers; [ fab ];
  };
}
