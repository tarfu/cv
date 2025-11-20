#!/bin/bash
# Installation Script für CV System
# Für Ubuntu/Debian basierte Systeme

set -e

echo "=== CV System Installation ==="
echo ""

# Prüfe ob Ruby installiert ist
if ! command -v ruby &> /dev/null; then
    echo "📦 Installiere Ruby..."
    sudo apt-get update
    sudo apt-get install -y ruby-full
else
    echo "✓ Ruby ist bereits installiert"
fi

# Prüfe ob asciidoctor installiert ist
if ! command -v asciidoctor &> /dev/null; then
    echo "📦 Installiere AsciiDoctor..."
    sudo apt-get install -y asciidoctor
else
    echo "✓ AsciiDoctor ist bereits installiert"
fi

# Prüfe ob asciidoctor-pdf installiert ist
if ! command -v asciidoctor-pdf &> /dev/null; then
    echo "📦 Installiere AsciiDoctor-PDF..."
    sudo apt-get install -y ruby-asciidoctor-pdf
else
    echo "✓ AsciiDoctor-PDF ist bereits installiert"
fi

echo ""
echo "✅ Installation abgeschlossen!"
echo ""
echo "Sie können jetzt PDFs generieren mit:"
echo "  cd cv-system"
echo "  ./build.sh"
echo ""
echo "Für weitere Informationen siehe README.adoc"
