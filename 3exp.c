#include <stdio.h>
#include <string.h>

char *T[5][6] = {
    {"tb","","","tb","",""},     // E
    {"","+tb","","","n","n"},    // B
    {"fc","","","fc","",""},     // T
    {"","n","*fc","n","n","n"},  // C
    {"i","","","(e)","",""}      // F
};

int row(char x){return x=='e'?0:x=='b'?1:x=='t'?2:x=='c'?3:x=='f'?4:-1;}
int col(char x){return x=='i'?0:x=='+'?1:x=='*'?2:x=='('?3:x==')'?4:x=='$'?5:-1;}

int main() {
    char in[50], st[50]; int top=1, pos=0;
    printf("Enter the input string: ");
    scanf("%s", in); strcat(in,"$");
    st[0]='$'; st[1]='e';
    printf("\nStack\tInput\n-----\t-----\n");
    while (st[top]!='$' || in[pos]!='$') {
        // print current stack
        for (int i=0; i<=top; i++) putchar(st[i]);
        printf("\t%s\n", in+pos);

        if (st[top]==in[pos]) { top--; pos++; }
        else {
            int r=row(st[top]), c=col(in[pos]);
            if (r<0||c<0||!*T[r][c]) return puts("ERROR"),0;
            if (T[r][c][0]=='n') top--;
            else {
                const char *p=T[r][c];
                top--;
                for (int i=strlen(p)-1;i>=0;i--) st[++top]=p[i];
            }
        }
    }
    puts("SUCCESS");
    return 0;
}
