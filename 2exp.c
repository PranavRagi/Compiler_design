#include <stdio.h>
#include <string.h>

int main(void) {
    char input[50], left[20], right1[20], right2[20];
    printf("Enter Production (e.g. A->Aa|b): ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = '\0';

    // Parse: split LHS, RHS1, RHS2
    sscanf(input, "%[^-]->%[^|]|%s", left, right1, right2);

    // Case 1: Left Recursion
    if (right1[0] == left[0]) {
        // left recursion removal
        printf("\nAfter Removing Left Recursion:\n");
        printf("%s -> %s%s'\n", left, right2, left);
        printf("%s' -> %s%s' | ε\n", left, right1 + 1, left);
    }
    // Case 2: Left Factoring
    else {
        // find common prefix
        int i = 0;
        while (right1[i] && right2[i] && right1[i] == right2[i]) i++;
        if (i > 0) {
            printf("\nAfter Left Factoring:\n");
            printf("%s -> %.*s%s'\n", left, i, right1, left);
            printf("%s' -> %s | %s\n", left, right1 + i, right2 + i);
        } else {
            printf("\nNo Left Recursion or Left Factoring needed.\n");
        }
    }

    return 0;
}

