#ifndef _EXECUTEUR_H_
#define _EXECUTEUR_H_
// #include "analyse_lexicale.h"
// #include "analyse_syntaxique.h"
// #include "compile_automate.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int N_line(FILE* fp);
int readVM(char* filename, char*** tableau);

char Exe_pop(char a, int id);
void Exe_push(char a, int id);
int Exe_is_vide(int id);
char Exe_top(int id);

typedef struct pile_VM_t{
    char (*pop)(char, int);
    void (*push)(char, int);
    int (*is_vide)(int);
    char (*top)(int);
}pile_VM;

// extern char** data_piles_VM;
// extern int* hauteur_piles_VM;

extern pile_VM Ma_Pile_VM;


#endif