{
  lib,
  aiohttp,
  azure-core,
  azure-datalake-store,
  azure-identity,
  azure-storage-blob,
  buildPythonPackage,
  fetchFromGitHub,
  fsspec,
  pythonOlder,
  setuptools,
  setuptools-scm,
}:

buildPythonPackage rec {
  pname = "adlfs";
  version = "2024.12.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "fsspec";
    repo = "adlfs";
    tag = version;
    hash = "sha256-s3nMvaH3YecABnFS7E4XPRWk8GwPVyqb9Qe2ejeXsZI=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    aiohttp
    azure-core
    azure-datalake-store
    azure-identity
    azure-storage-blob
    fsspec
  ];

  # Tests require a running Docker instance
  doCheck = false;

  pythonImportsCheck = [ "adlfs" ];

  meta = with lib; {
    description = "Filesystem interface to Azure-Datalake Gen1 and Gen2 Storage";
    homepage = "https://github.com/fsspec/adlfs";
    changelog = "https://github.com/fsspec/adlfs/blob/${version}/CHANGELOG.md";
    license = licenses.bsd3;
    maintainers = with maintainers; [ fab ];
  };
}
