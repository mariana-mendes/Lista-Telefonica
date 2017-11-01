# include <bits/stdc++.h>
# include <map>

using namespace std;

map <string,int> contatos;
vector<string> contatosAuxiliar;


void printMenu(){
    printf("%s\n","------ Lista Telefonica topzera ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Adicionar contato.");
	  printf("%s\n","2. Excluir contato.");
}

void addContato(string nome,  int numero){
  contatosAuxiliar.push_back(nome);
  contatos.insert(pair <string,  int> (nome, numero));
};


void listContatos(){
	for(int i = 0; i < contatosAuxiliar.size() ; i++){
		cout << contatosAuxiliar.at(i) << endl;
		printf("%d\n", contatos[contatosAuxiliar[i]]);
		
	};
  
}


int main(){
  printMenu();
  int opcao;
  string nome;
  int numero;
  cout << "Digite sua opção: ";
  scanf("%d",&opcao);
  
  if(opcao == 1){
    cout << "Nome do contato: ";
    cin >> nome;
    cout << "Numero do contato: ";
    scanf( "%d",&numero);
    addContato(nome,numero);
    
  };
  
  listContatos();
    

return 0;
	}
	
	
	
