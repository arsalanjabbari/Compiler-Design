%{

#define YYSTYPE_IS_DECLARED 1
typedef char* YYSTYPE;

#include <stdio.h>
#include <string.h>

char *three_code(char* expr1, char operand, char* expr3);
char *finalize(char* expr);

char *the_final;
int t = 1;
char* val_mem[1000];

%}


%token NUMBER


%%


start : expr '=' { finalize($1); }
	  ;
expr  : expr '+' term { $$ = three_code($1, '+', $3); } 
      | expr '-' term { $$ = three_code($1, '-', $3); }
	  | term
	  ;
term  : term '*' factor { $$ = three_code($1, '*', $3); }
	  | term '/' factor { $$ = three_code($1, '/', $3); }
	  | factor
	  ;
factor: '(' expr ')' { $$ = $2; }
	  | NUMBER
	  ;


%%

char* plus_minus(char* a, char* b, int op){
	char* res = malloc(1000);
	int len = 0;
	if(op){
		strcpy(res,a);
		len = strlen(a);
		for(int i = 0; b[i]; i++){
			if(!strchr(a, b[i])){
				res[len] = b[i];
				len++;
			}
		}
	}
	else{
		len = 0;
		for(int i = 0; a[i]; i++){
			if(!strchr(b, a[i])){
				res[len] = a[i];
				len++;
			}
		}
	}
	res[len] = 0;
	return res;
}

int sum_of_digits(int i) {
	int res = 0;
	while(i){
		res += i % 10;
		i /= 10;
	}
	if(res >= 10)
		return sum_of_digits(res);
	return res;
}

char* mul_div(char* a, char* b, int op){
	char* res = malloc(1000);
	int d;
	int len = 0;
	sscanf(b,"%d",&d);
	d = sum_of_digits(d);
	if(op){
		strcpy(res,a);
		len = strlen(a);
		if(!strchr(a,d + '0')){
			res[len] = d + '0';
			len++;
		}
	}
	else{
		len = 0;
		for(int i = 0; a[i]; i++){
			if(a[i] != d + '0'){
				res[len] = a[i];
				len++;
			}
		}
	}
	res[len] = 0;
	return res;
}

char* three_code(char* expr1, char operand, char* expr3) {

	char* vl = malloc(1000);
	char* vr = malloc(1000);
	char* res = malloc(1000);
	char* ntemp = malloc(t/10 + 3);


    printf(the_final);
    sprintf(ntemp, "t%d", t++);


	int numt;
	if(expr1[0] == 't'){
		sscanf(expr1, "t%d", &numt);
		vl = val_mem[numt];
	}
	else
		strcpy(vl, expr1);


	if(expr3[0] == 't'){
		sscanf(expr3, "t%d", &numt);
		vr = val_mem[numt];
	}
	else
		strcpy(vr,expr3);


	if(operand == '+')
		res = plus_minus(vl, vr, 1);
	if(operand == '-')
		res = plus_minus(vl, vr, 0);
	if(operand == '*')
		res = mul_div(vl, vr, 1);
	if(operand == '/')
		res = mul_div(vl, vr, 0);

		
    sprintf(the_final, "%s = %s %c %s;\n%s = %s;\n", ntemp, expr1, operand, expr3, ntemp, res);
	val_mem[t-1] = malloc(1000);
	strcpy(val_mem[t-1], res);
    return ntemp;
}

char* finalize(char* expr) {

    char* int_temp = malloc(10000);
	char* expr1 = malloc(10000);
	char* expr3 = malloc(10000);
	char* vl = malloc(1000);
	char* vr = malloc(1000);
	char* res = malloc(1000);
	
	char operand;
	int lex;


	if(t != 1){
        sscanf(the_final, "t%d = %10000[^\n]", &lex, int_temp);
		sscanf(the_final, "t%d = %s %c %s", &lex, expr1, &operand, expr3);
    }
	else
        strcpy(int_temp, expr);


	int numt;
	if(expr1[0] == 't'){
		sscanf(expr1, "t%d", &numt);
		vl = val_mem[numt];
	}
	else
		strcpy(vl, expr1);


	if(expr3[0] == 't'){
		sscanf(expr3, "t%d", &numt);
		vr = val_mem[numt];
	}
	else
		strcpy(vr, expr3);


	if(operand == '+')
		res = plus_minus(vl, vr, 1);
	if(operand == '-')
		res = plus_minus(vl, vr, 0);
	if(operand == '*')
		res = mul_div(vl, vr, 1);
	if(operand == '/')
		res = mul_div(vl, vr, 0);
		

    printf("t%d = %s\n", t - 1, int_temp);
	printf("t%d = %s;\n", lex, res);

    free(int_temp);
}

int main() {
    the_final = malloc(100000);
    the_final[0] = 0;
    if (yyparse() != 0)
        printf("Abnormal exit\n");
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
}