#pragma warning(disable:4996)
#include <stdio.h>

char username[20] = "wenhao";
char userpassword[20] = "1234567";
char tempname[20];
char temppassword[20];
char w_sign[10];
extern int ccm;
extern char MIDME;
extern int sign;
extern void __stdcall process(int asd);
extern int signofwait;
extern char input;
int compare_s(char *str1, char *str2)
{
	int i = 0;
	while (str1[i] != '\0')
	{
		if (str1[i] != str2[i])
			return 0;
		i++;
	}
	return 1;
}

void process_login(int cnt)
{
	printf("Please input your name: ");
	scanf("%s", tempname);
	printf("Please input your password: ");
	scanf("%s", temppassword);
	if (compare_s(username, tempname) && compare_s(userpassword, temppassword))
	{
		printf("Login success!\n");
		sign = 1;
		return;
	}
	else
	{
		if (cnt == 3)
		{
			printf("Login failed!\n");
			sign = 0;
			return;
		}
		printf("Wrong!\n");
		printf("%d times left\n", 3 - cnt);
		process_login(cnt + 1);
		return;
	}
}

void outputMIDF()
{
	printf("数据收集完毕\n");
	int tempccm = 0;
	char* ptr_mid = &MIDME;
	while (tempccm < ccm)
	{
		
		printf("%s\n", (char*)ptr_mid);
		printf("%u\n", *(unsigned int*)(ptr_mid + 6));
		printf("%u\n", *(unsigned int*)(ptr_mid + 10));
		printf("%u\n", *(unsigned int*)(ptr_mid + 14));
		printf("%u\n", *(unsigned int*)(ptr_mid + 18));
		printf("------------------------------------------------------\n");
		tempccm += 22;
		ptr_mid += 22;
	}
	return ;
}

void waitto()
{
	printf("press R to recaculate\n");
	printf("press Q to quit\n");
	printf("press M to change\n");
	getchar();
	scanf("%s", w_sign);
	if (w_sign[1] != 0)	waitto();
	if (w_sign[0] == 'R')
	{
		signofwait = 1;
		return ;
	}
	if (w_sign[0] == 'Q')
	{
		signofwait = 2;
		return ;
	}
	if (w_sign[0] == 'M')
	{
		signofwait = 3;
		return ;
	}
	waitto();
}

void change_me()
{
	printf("please input samid\n");
	char samid[10];
	scanf("%s",samid);
	char * ptr_input = &input;
	ptr_input[0] = samid[0];
	ptr_input[1] = samid[1];
	ptr_input[2] = samid[2];
	ptr_input[3] = samid[3];
	ptr_input[4] = samid[4];
	ptr_input[5] = 0;
	printf("please input a\n");
	int a;
	scanf("%d", &a);
	*(int*)(ptr_input + 6) = a;
	printf("please input b\n");
	int b;
	scanf("%d", &b);
	*(int*)(ptr_input + 10) = b;
	printf("please input c\n");
	int c;
	scanf("%d", &c);
	*(int*)(ptr_input + 14) = c;
	return ;
}