{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, beautifulsoup4
, datetime
, lxml
, pandas
, pytest-mock
, pytestCheckHook
, requests
}:

buildPythonPackage rec {
  pname = "finvizfinance";
  version = "0.14.6";
  format = "setuptools";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "lit26";
    repo = "finvizfinance";
    rev = "refs/tags/v${version}";
    hash = "sha256-YRdOj0n2AUGRicQCENoXWad5MnRyTqQFxqisTFnClac=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "bs4" "beautifulsoup4"
  '';

  nativeCheckInputs = [
    pytest-mock
    pytestCheckHook
  ];

  propagatedBuildInputs = [
    beautifulsoup4
    datetime
    lxml
    pandas
    requests
  ];

  pythonImportsCheck = [
    "finvizfinance"
  ];

  disabledTests = [
    # Tests require network access
    "test_finvizfinance_calendar"
    "test_finvizfinance_crypto"
    "test_forex_performance_percentage"
    "test_group_overview"
    "test_finvizfinance_insider"
    "test_finvizfinance_news"
    "test_finvizfinance_finvizfinance"
    "test_statements"
    "test_screener_overview"
  ];

  meta = with lib; {
    description = "Finviz Finance information downloader";
    homepage = "https://github.com/lit26/finvizfinance";
    changelog = "https://github.com/lit26/finvizfinance/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ icyrockcom ];
  };
}

