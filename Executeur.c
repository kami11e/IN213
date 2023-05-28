#include "Executeur.h"

char** data_piles_VM;
int* hauteur_piles_VM;
char** tableau;

pile_VM Ma_Pile_VM={
    Exe_pop,
    Exe_push,
    Exe_is_vide,
    Exe_top
};
int debug;

char Exe_pop(char a, int id){
    if(hauteur_piles_VM[id]==0){
        // printf("%s, %d : Erreur syntaxique\n", __func__, __LINE__ );
        return 0;
    }else if(a==data_piles_VM[id][hauteur_piles_VM[id]-1]){
        // printf("%s:h=%d\n", __func__,hauteur_piles_VM[id]-1);
        return(data_piles_VM[id][--hauteur_piles_VM[id]]);
    }else{
        // printf("%s, %d : Erreur syntaxique\n", __func__, __LINE__ );
        return -1;
        
    }
}
void Exe_push(char a, int id){
    if(hauteur_piles_VM[id]==50){
        printf("Not enough space for pile de parenthese\n");
        return;
    }else{
        data_piles_VM[id][hauteur_piles_VM[id]++]=a;
        // printf("%s:h=%d\n", __func__,hauteur_piles_VM[id]);
        return;
    }
}
int Exe_is_vide(int id){
    return (hauteur_piles_VM[id]==0);
}
char Exe_top(int id){
    if (hauteur_piles_VM[id]>0){
        return data_piles_VM[id][hauteur_piles_VM[id]-1];
    }else{
        return 0;
    }
}



int N_line(FILE* fp){
    int ret=0;
    fseek(fp, 0L, SEEK_SET);
    char tmp[20];
    while (fgets(tmp, 20, fp)!=NULL){
        ret++;
    }
    return ret;
}

int readVM(char* filename, char*** tableau){
    // printf("readVM\n");
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Le fichier %s est introuvable\n", filename);
        return -1;
    }
    int n_line = N_line(fp);
    fseek(fp, 0L, SEEK_SET);
    *tableau = (char**)malloc(sizeof(char*)*n_line);
    char tmp[20];
    // printf("N=%d\n", n_line);
    for(int i=0; i<n_line;i++){
        fgets(tmp, sizeof(tmp), fp);
        (*tableau)[i] = (char*)malloc(sizeof(char)*strlen(tmp));
        memcpy((*tableau)[i], tmp, strlen(tmp)*sizeof(char));
        // printf("%d:%s", i, (*tableau)[i]);
    }

    return n_line;
}

char** tableau_symbol;
int* list_addr;

int readTS(char* filename, char*** tableau_symbol, int** list_addr){
    // printf("readTS\n");
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Le fichier %s est introuvable\n", filename);
        return -1;
    }
    int n_line = N_line(fp);
    fseek(fp, 0L, SEEK_SET);
    *tableau_symbol = (char**)malloc(sizeof(char*)*n_line);
    *list_addr = (int*)malloc(sizeof(int)*n_line);
    char tmp[20];
    // printf("N=%d\n", n_line);
    for(int i=0; i<n_line;i++){
        fgets(tmp, sizeof(tmp), fp);
        int i1=0;
        for(int i=0; i<strlen(tmp);i++){
            if(tmp[i]==':'){
                i1 = i+1;
                break;
            }
        }
        int j;
        char* tmp2;
        for(j=i1;j<strlen(tmp);j++){
            if(tmp[j]==' '){
                tmp2 = &tmp[j+1];
                tmp[j]=0;
                break;
            }
        }
        (*tableau_symbol)[i] = (char*)malloc(sizeof(char)*strlen(tmp));
        memcpy((*tableau_symbol)[i], &tmp[i1], strlen(tmp));
        int k;
        for(k=0; k<strlen(tmp2);k++){
            if(tmp2[k]==':'){
                break;
            }
        }
        (*list_addr)[i] = atoi(&tmp2[k+1]);

    }
    // printf("end_readTS\n");
    return n_line;
}

char* addr2name(int addr, int n_etat){
    for(int i=0;i<n_etat;i++){
        if(list_addr[i]==addr){
            return tableau_symbol[i];
        }
    }
    return NULL;
}

int Executer(char** tableau, int N, char* expr, int n_etat){
    // printf("Executer\n");
    int exprlen = strlen(expr);
    int n_pile = atoi(tableau[0]);
    data_piles_VM = (char**)malloc(sizeof(char*)*n_pile);
    hauteur_piles_VM = (int*)malloc(sizeof(int)*n_pile);
    // Ma_Pile_VM = (pile_VM*)malloc(sizeof(pile_VM)*n_pile);

    for(int i=0;i<n_pile;i++){
        // printf("%d,n_pile=%d\n", __LINE__, n_pile);
        data_piles_VM[i] = (char*)malloc(sizeof(char)*50);
        memset(data_piles_VM[i], 0, 50);
        hauteur_piles_VM[i] = 0;
    }
    
    int n_etat_final = atoi(tableau[2]);
    int etat_addr = atoi(tableau[1]);
    if(debug){
        printf("  -> État : %s", addr2name(etat_addr, n_etat));
        for(int k=0;k<n_pile;k++){
            printf("\tPile %d : Vide", k+1);
        }
        printf("\n");
    }
    for(int i=0; i<exprlen;i++){
        // printf("%d, %d\n", i, __LINE__);
        int ici = etat_addr;
        int etat_n_trans = atoi(tableau[ici]);
        int transflag=0;
        // int ancien;
        int jj;
        for(jj=0;jj<etat_n_trans;jj++){
            if(expr[i]==atoi(tableau[ici+1+jj*(2+2*n_pile)])){
                // ici++;
                transflag = 1;
                // ancien = ici;
                etat_addr = atoi(tableau[ici+2+jj*(2+2*n_pile)]);
                // printf("%d, %d, addr=%d,  ici=%d\n", i, __LINE__, etat_addr, ici);
                break;
            }
        }
        // printf("%d, %d, addr=%d\n", i, __LINE__, etat_addr);
        if(transflag){
            // ici=etat_addr;
            
            if(debug)printf("%c -> État : %s", expr[i], addr2name(etat_addr, n_etat));
            for(int j=0; j<n_pile;j++){
                // printf("  ici=%d, j=%d ", ici, j);
                if(atoi(tableau[ici+4+2*jj])==1){
                    Ma_Pile_VM.push(atoi(tableau[ici+3+2*jj]),j);
                }else if(atoi(tableau[ici+4+2*j])==-1){
                    char flag = Ma_Pile_VM.pop(atoi(tableau[ici+3+2*jj]), j);
                    if(flag==0){
                        if(debug)printf("\r%c -> Erreur : Pile %d vide !\n", expr[i], j+1);
                        printf("Le mot %s est refusé !\n", expr);
                        return -1;
                    }else if(flag==-1){
                        if(debug)printf("\r%c -> Erreur : Pile %d pop() erreur !\n", expr[i], j+1);
                        printf("Le mot %s est refusé !\n", expr);
                    }
                }
                if(debug){
                    printf("\tPile %d : ", j+1);
                    // printf("h1=%d  h2=%d\n", hauteur_piles_VM[0], hauteur_piles_VM[1]);
                    if(hauteur_piles_VM[j]>0){
                        for(int k=0;k<hauteur_piles_VM[j];k++){
                            printf("%c", data_piles_VM[j][k]);
                        }
                    }else{
                        printf("Vide");
                    }
                }
            }
            ici=etat_addr;
            if(debug)printf("\n");
        }else{
            printf("Le mot %s est refusé !\n", expr);
            return -1;
        }

    }
    int is_final = 0;
    for(int i=0; i<n_etat_final;i++){
        if(atoi(tableau[3+i])==etat_addr){
            is_final=1;
            break;
        }
    }
    int* is_not_vide=(int*)malloc(sizeof(int)*n_pile);
    int n_non_vide=0;
    for(int i=0; i<n_pile;i++){
        if(Ma_Pile_VM.is_vide(i)!=1){
            is_not_vide[i]=1;
            n_non_vide++;
        }else{
            is_not_vide[i]=0;
        }
    }
    if(!is_final){
        printf("L'état courant n'est pas un état d'acceptation !\n");
        return -1;
    }
    if(n_non_vide){
        printf("Le mot %s est refusé ! Pile ", expr);
        for(int i=0;i<n_pile;i++){
            if(Ma_Pile_VM.is_vide(i)!=1){
                n_non_vide--;
                n_non_vide>0?printf("%d, ", i+1):printf("%d non vide", i+1);
            }
            
        } 
        if(n_non_vide>1)printf("s\n");
        else printf("\n");
        return -1;
    }
    printf("Le mot %s est accepté !\n", expr);
    return 0;
}

int main(int argc, char* argv[]){

    char vm[20];
    char ts[20];
    
    int arg_pos = 1;

    debug = 0;
    if (argc > 1) {
        if(!strcmp(argv[1], "-debug")){
            debug = 1;
            arg_pos = 2;
        }
    }

    strcpy(vm, "VM");
    strcpy(ts, "TS");

    if (argc > arg_pos)
        strcpy(vm, argv[arg_pos]);

    if (argc > arg_pos+1)
        strcpy(ts, argv[arg_pos+1]);
   
    // printf("VM=%s, TS=%s\n", vm, ts);

    char expr[100];
    printf(">>>>>>>>>>>>>>>>>>>>Exécution<<<<<<<<<<<<<<<<<<<\n");
	printf("Donner le mot d'entrée : ");
	char c = getchar();
	int i=0;
	while(c != '\n') {
		expr[i] = c;
		i++;
		c = getchar();
	}
	expr[i]=0;
    // printf("N=%d\n", N_line(fp))
    // char** tableau;
    // printf("%d\n", __LINE__);

    int N = readVM(vm, &tableau);
    // printf("%d\n", __LINE__);
    int n = readTS(ts, &tableau_symbol, &list_addr);
    if (N <= 0 || n <= 0) 
        return -1;

    Executer(tableau, N, expr, n);
    return 0;
}