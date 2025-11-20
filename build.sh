#!/bin/bash
# CV Build Script
# Generiert verschiedene Versionen des CVs

set -e

# Farben für Output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== CV Build System ===${NC}"

# Erstelle output Verzeichnis falls nicht vorhanden
mkdir -p output

# Prüfe ob asciidoctor-pdf installiert ist
if ! command -v asciidoctor-pdf &> /dev/null; then
    echo "⚠️  asciidoctor-pdf ist nicht installiert."
    echo "Installation mit: gem install asciidoctor-pdf"
    exit 1
fi

# Funktion für PDF-Generierung
generate_pdf() {
    local name=$1
    local theme=$2
    local attributes=$3
    local source_file=$4
    local output_file="output/${name}.pdf"

    echo -e "${BLUE}Generiere ${name}...${NC}"

    asciidoctor-pdf \
        -a pdf-theme=${theme} \
        -a pdf-themesdir=themes \
        ${attributes} \
        ${source_file} \
        -o "${output_file}"

    echo -e "${GREEN}✓ ${name} erstellt: ${output_file}${NC}"
}

# Verschiedene Versionen generieren

echo -e "${BLUE}--- Deutsche Versionen ---${NC}"

# 1. Vollversion mit jernoxIT Design (Deutsch)
generate_pdf "CV_Tobias_Breitwieser_Vollversion_DE" "jernoxit" "-a full-version" "cv-main.adoc"

# 2. Kurzversion mit jernoxIT Design (Deutsch, ohne Archiv-Projekte)
generate_pdf "CV_Tobias_Breitwieser_Kurzversion_DE" "jernoxit" "" "cv-main.adoc"

# 3. Minimal Design Vollversion (Deutsch)
generate_pdf "CV_Tobias_Breitwieser_Minimal_DE" "minimal" "-a full-version" "cv-main.adoc"

echo ""
echo -e "${BLUE}--- English Versions ---${NC}"

# 4. Full Version with jernoxIT Design (English)
generate_pdf "CV_Tobias_Breitwieser_Full_EN" "jernoxit" "-a full-version" "cv-main-en.adoc"

# 5. Short Version with jernoxIT Design (English, without archive projects)
generate_pdf "CV_Tobias_Breitwieser_Short_EN" "jernoxit" "" "cv-main-en.adoc"

# 6. Minimal Design Full Version (English)
generate_pdf "CV_Tobias_Breitwieser_Minimal_EN" "minimal" "-a full-version" "cv-main-en.adoc"

# Zeige erzeugte Dateien
echo ""
echo -e "${BLUE}=== Erzeugte Dateien ===${NC}"
ls -lh output/*.pdf

echo ""
echo -e "${GREEN}✓ Build abgeschlossen!${NC}"
echo ""
echo "Tipp: Für individuelle Builds verwenden Sie:"
echo "  Deutsch:   asciidoctor-pdf -a pdf-theme=jernoxit cv-main.adoc -o output/custom_de.pdf"
echo "  English:   asciidoctor-pdf -a pdf-theme=jernoxit cv-main-en.adoc -o output/custom_en.pdf"
