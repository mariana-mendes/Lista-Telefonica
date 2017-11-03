# include <bits/stdc++.h>
# include <map>
#include <algorithm>

using namespace std;

struct Contato{
	string nome;
	int numero;
	bool favorito;
	bool bloqueado;
	int contaChamadas;
	vector<string> grupos;
};

vector<Contato> contatos;

Contato criaContato(string nome, int numero){
	Contato contato;
	contato.nome=nome;
	contato.numero = numero;
	contato.favorito = 0;
	contato.bloqueado = 0;
	contato.contaChamadas = 0;
	
	return contato;
};

void printMenu(){
    printf("%s\n","------ Lista Telefonica topzera ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Adicionar contato.");
	printf("%s\n","2. Excluir contato.");
	printf("%s\n","3. Listar contatos.");
	cout << "Digite sua opção: ";
};


void addContato(){
	string nome;
	int numero;
	Contato novoContato;
	cout << "Nome do contato: ";
	cin >> nome;
	cout << "Numero do contato: ";
	cin>> numero;
	novoContato = criaContato(nome, numero);
	contatos.push_back(novoContato);
};


void deleteContato(){
	cout<< "Nome do contato: "<<endl;
	string nome;
	cin >> nome;
	for(int i = 0; i < contatos.size(); i++){
			if(contatos.at(i).nome == nome){
				contatos.erase(contatos.begin()+ i);
				break;
			};
	}
	
	
}


void listaContatos(){
	for(int i = 0; i < contatos.size() ; i++){
		cout << "Nome: " <<contatos.at(i).nome << endl;
	};
  
}


int main(){	
  printMenu();
  int opcao;
  scanf("%d",&opcao);
  
  
  switch(opcao){
	  case 1:
		addContato();
		cout<< "Contato adicionado com sucesso!"<< endl;
		break;
	  case 2:
		deleteContato();
		cout << "Excluído com sucesso!" <<endl;
	  case 3:
		cout << "Todos os contatos: " << endl;
		listaContatos(); 

  
 
};
}
	
	
	
