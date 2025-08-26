#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define MAX_ID_LEN 50

// Function to check if a character is an operator
int isOperator(char ch) {
    char operators[] = "+-*/=%<>&|!";
    for (int i = 0; operators[i] != '\0'; i++) {
        if (ch == operators[i]) return 1;
    }
    return 0;
}

// Function to check if a character is a delimiter
int isDelimiter(char ch) {
    return (ch == ' ' || ch == '\n' || ch == '\t' ||
            ch == ';' || ch == ',' || ch == '(' || ch == ')' ||
            ch == '{' || ch == '}');
}

int main() {
    // Instead of reading from a file, we hardcode a test input string
    char source[] = "int main() {\n"
                    "   int a = 10; // this is a comment\n"
                    "   a = a + 5;\n"
                    "}\n";

    char buffer[MAX_ID_LEN];
    int i = 0;
    char ch;
    int pos = 0;

    while ((ch = source[pos++]) != '\0') {
        // Skip whitespace
        if (isspace(ch)) continue;

        // Handle single-line comment "//"
        if (ch == '/') {
            char next = source[pos];
            if (next == '/') {
                // Skip until end of line
                while ((ch = source[pos++]) != '\n' && ch != '\0');
                continue;
            } else {
                printf("Operator: /\n");
                continue;
            }
        }

        // If operator
        if (isOperator(ch)) {
            printf("Operator: %c\n", ch);
            continue;
        }

        // If constant (number)
        if (isdigit(ch)) {
            printf("Constant: %c", ch);
            while ((ch = source[pos++]) != '\0' && isdigit(ch)) {
                printf("%c", ch);
            }
            printf("\n");
            pos--; // step back one character
            continue;
        }

        // If identifier (starts with letter or underscore)
        if (isalpha(ch) || ch == '_') {
            i = 0;
            buffer[i++] = ch;
            while ((ch = source[pos++]) != '\0' && (isalnum(ch) || ch == '_')) {
                if (i < MAX_ID_LEN - 1) buffer[i++] = ch;
            }
            buffer[i] = '\0';
            printf("Identifier: %s\n", buffer);
            pos--; // step back one character
            continue;
        }

        // Ignore delimiters
        if (isDelimiter(ch)) {
            continue;
        }
    }

    return 0;
}
