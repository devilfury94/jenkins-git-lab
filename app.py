import os
version = os.getenv("APP_VERSION", "dev")
environment = os.getenv("APP_ENV", "development")
print(f"DEVOPS FINAL | VERSION={version} | ENV={environment}")
