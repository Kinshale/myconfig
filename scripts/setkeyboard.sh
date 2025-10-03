#!/bin/bash

echo "Choose a keyboard layout:"
echo "1) us (English US)"
echo "2) it (Italian)"
echo "3) alessandro (Custom)"

read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        setxkbmap us
        echo "Keyboard layout set to US."
        ;;
    2)
        setxkbmap it
        echo "Keyboard layout set to Italian."
        ;;
    3)
        setxkbmap alessandro
        echo "Keyboard layout set to Alessandro (custom)."
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
