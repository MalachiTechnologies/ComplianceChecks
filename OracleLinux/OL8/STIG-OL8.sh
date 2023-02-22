#!/bin/bash

# Install the OpenSCAP tools if not already installed
if ! command -v oscap &> /dev/null
then
    echo "Installing OpenSCAP tools..."
    sudo dnf install -y openscap-scanner
fi

# Run the SCAP scan with the DISA STIG profile
echo "Running SCAP scan..."
oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_stig --results ~/scan-results-ol8.xml --report ~/scan-report-ol8.html /usr/share/xml/scap/ssg/content/ssg-ol8-ds.xml

# Check if any vulnerabilities were found
if grep -q "fail" scan-results-ol8.xml
then
    echo "Vulnerabilities found!"
    echo "The Results have been saved into an HTML report viewable in your web browser at " ~/stig-checks/"scan-report-ol8.html"
else
    echo "No vulnerabilities found."
    echo "The Results have been saved into an HTML report viewable in your web browser at " ~/stig-checks/"scan-report-ol8.html"
fi
