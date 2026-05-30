fetch_versions() {
    curl -s https://mcversions.net/ | tr ' ' '\n' | grep href=\"/download/ | sed 's/href=\"\/download\///g' | cut -d'"' -f1
}
