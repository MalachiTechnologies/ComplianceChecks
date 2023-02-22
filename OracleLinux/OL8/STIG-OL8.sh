#!/bin/bash

# Define the DISA STIG profile for Oracle Linux 8.7
STIG_PROFILE="stigprofile-rhel8-ds.xml"

# Install the OpenSCAP tools if not already installed
if ! command -v oscap &> /dev/null
then
    echo "Installing OpenSCAP tools..."
    sudo yum install -y openscap-scanner
fi

# Run the SCAP scan with the DISA STIG profile
echo "Running SCAP scan..."
oscap xccdf eval \    
	--profile xccdf_org.ssgproject.content_profile_stig \
	--results scan-results.xml \
	--report scan-report.html \
	/usr/share/xml/scap/ssg/content/ssg-ol8-ds.xml

# Check if any vulnerabilities were found
if grep -q "fail" scan-results.xml
then
    echo "Vulnerabilities found!"
else
    echo "No vulnerabilities found."
fi
