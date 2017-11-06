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
	printf("%s\n","4. Editar contato.");
	cout << "Digite sua opção: ";
};

void printMenuEditarContato(){
    printf("%s\n","------   contato  ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Modificar o nome.");
	printf("%s\n","2. Modificar o número.");
	printf("%s\n","3. Alterar grupo.");
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
		cout << "Número: " <<contatos.at(i).numero << endl;
	};
  
}



Contato editarContato(Contato contato){
	printMenuEditarContato();
	int opcao,numero;
	string nomes;
	scanf("%d",&opcao);
	switch(opcao){
		  case 1:
			
			cout << "Digite o novo nome: "<< endl;
			cin >> nomes;
			contato.nome = nomes;
		  case 2:
			int numero;
			cout << "Digite o novo número: "<< endl;
			cin >> numero;
			contato.numero = numero;
		 };
	return contato;
};
void procuraContato(){
	cout<< "Nome do contato:";
	string nome; 
	cin >> nome;
	Contato contato;
	for(int i = 0; i < contatos.size() ; i++){
		if(contatos.at(i).nome == nome){
			 contato = editarContato(contatos.at(i));
			 contatos.at(i).numero = contato.numero;
			 contatos.at(i).nome = contato.nome;
			 cout << "Contato editado com sucesso!"<< endl;
			return;
			};
	};
	cout << "Não foi possível encontrar o contato."<< endl;
	
};


int main(){	
  while (true){
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
		  case 4:
			procuraContato();
	};		
};
}
	
	
	
