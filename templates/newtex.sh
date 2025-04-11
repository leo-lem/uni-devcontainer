#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <type: exercise|summary> <destination>.tex"
    exit 1
fi

# Assign arguments to variables
TYPE=$1
DESTINATION="$2.tex"

# Create the file based on the type
case $TYPE in
    exercise)
        cat << 'EOF' > "$DESTINATION"
\documentclass{article}

\usepackage[]{xrcise}

\subject{<subject>}
\semester{<semester>}
\author{Leopold Lemmermann}

\begin{document}\createtitle

\section{}

\end{document}
EOF
        ;;
    summary)
        cat << 'EOF' > "$DESTINATION"
\documentclass{article}

\usepackage{summary}

\subject{<subject>}
\semester{<semester>}
\author{Leopold Lemmermann}

\begin{document}\createtitle

\section{}

\end{document}
EOF
        ;;
    *)
        echo "Error: Invalid type. Use 'exercise' or 'summary'."
        exit 1
        ;;
esac

# Confirm success
if [ $? -eq 0 ]; then
    echo "File created successfully at $DESTINATION"
else
    echo "Error: Failed to create file."
    exit 1
fi