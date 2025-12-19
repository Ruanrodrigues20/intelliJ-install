#!/usr/bin/env python3
import sys
import requests

def get_latest_version(product_code):
    """
    Fetch the latest JetBrains release version for the given product code.
    Prints only the version string, suitable for use in Bash.
    """
    url = f"https://data.services.jetbrains.com/products/releases?code={product_code}&latest=true&type=release"
    try:
        resp = requests.get(url, timeout=10)
        resp.raise_for_status()
        data = resp.json()

        # Check if product code exists in data
        if product_code not in data or not data[product_code]:
            print(f"Error: No release data found for product code '{product_code}'", file=sys.stderr)
            sys.exit(1)

        version = data[product_code][0]["version"]
        print(version)
    except requests.RequestException as e:
        print(f"Error fetching version for {product_code}: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <PRODUCT_CODE>", file=sys.stderr)
        print("Example product codes: IIU (IntelliJ Ultimate), PCP (PyCharm Pro)", file=sys.stderr)
        sys.exit(1)
    product_code = sys.argv[1]
    get_latest_version(product_code)
