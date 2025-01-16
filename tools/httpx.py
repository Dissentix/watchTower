import json
import os
import tempfile
from typing import List, Dict

from utils import run_command_in_zsh

class Colors:
    GRAY = "\033[90m"
    RESET = "\033[0m"

def httpx(subdomains: List[str], domain: str) -> List[Dict]:
    with tempfile.NamedTemporaryFile(mode="w", delete=False) as temp_file:
        temp_file.write("\n".join(subdomains))
        subdomains_file = temp_file.name

    command = (
        f"httpx -l {subdomains_file} -silent -json -favicon -fhr -tech-detect "
        f"-irh -include-chain -timeout 3 -retries 1 -threads 5 -rate-limit 4 "
        f"-extract-fqdn -H 'Referer: https://{domain}' -http2"
    )

    print(f"{Colors.GRAY}Executing command: {command}{Colors.RESET}")

    result = run_command_in_zsh(command, read_line=False)
    
    try:
        responses = [json.loads(r) for r in result.splitlines()]
    finally:
        os.remove(subdomains_file)

    return responses
