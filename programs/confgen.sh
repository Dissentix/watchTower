#!/bin/bash

# Function to prompt user for program name and domains
generate_json() {
    # Ask for the program name
    echo "Enter the program name (e.g., adidas):"
    read program_name

    # Ask for the in-scope domains
    echo "Enter the in-scope domains (comma-separated, no spaces, e.g., adidas.com,adidas.de):"
    read in_scopes

    # Ask for out-of-scope domains
    echo "Enter the out-of-scope domains (comma-separated, no spaces, e.g., doc.adidas.com):"
    read out_scopes

    # Convert comma-separated values to JSON array format
    in_scopes_array=$(echo $in_scopes | sed 's/,/","/g')
    out_scopes_array=$(echo $out_scopes | sed 's/,/","/g')

    # Create the JSON structure
    json_content=$(cat <<EOF
{
    "program_name": "$program_name",
    "scopes": [
        "$in_scopes_array"
    ],
    "ooscopes": [
        "$out_scopes_array"
    ],
    "config": {
        "providers": [
            "crtsh",
            "subfinder",
            "abuseipdb",
            "wayback"
        ]
    }
}
EOF
)

    # Create the output JSON file with the program name
    echo "$json_content" > "${program_name}.json"

    # Notify the user
    echo "JSON file ${program_name}.json has been created!"
}

# Run the function
generate_json
