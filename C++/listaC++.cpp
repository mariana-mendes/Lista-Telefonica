# include <bits/stdc++.h>
# include <map>
#include <algorithm>
#include <typeinfo>
#include <regex>
using namespace std;


struct Contato{
	string nome;
	string numero;
	bool favorito;
	bool bloqueado;
	int contaChamadas;
	vector<string> grupos;
};
vector<Contato> contatos;

Contato criaContato(string nome, string numero){
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
	printf("%s\n","4. Busca contato.");
	cout << "Digite sua opção: ";
};

void printMenuContato(){
	printf("%s\n","------ Opcões contato ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Editar Contato");
    printf("%s\n","2. Chamar");
    printf("%s\n","3. Adcionar aos Favoritos");
    printf("%s\n","4. Adicionar à Grupo");
}

void printMenuEditarContato(){
    printf("%s\n","------   contato  ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Modificar o nome.");
	printf("%s\n","2. Modificar o número.");
	printf("%s\n","3. Alterar grupo.");
	cout << "Digite sua opção: ";
};

void addContato(){
  regex r("\\([[:digit:]]{2}\\)[[:digit:]]{1}-[[:digit:]]{4}-[[:digit:]]{4}");
	string nome;
	string numero;
	Contato novoContato;
	cout << "Nome do contato: ";
	cin >> nome;

	cout << "Numero do contato((xx)x-xxxx-xxxx): ";
	cin>> numero;
	if (regex_match(numero, r)) {
	  novoContato = criaContato(nome, numero);
	  contatos.push_back(novoContato);
	} else {
	  cout << "Formato Inválido: Insira dados válidos \n";
	  addContato();
	}
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

Contato menuEdicao(Contato contato){
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

void editarContato(Contato contatoRecebido){
	Contato contato;
	for(int i = 0; i < contatos.size() ; i++){
		if(contatos.at(i).nome == contatoRecebido.nome){
			 contato = menuEdicao(contatos.at(i));
			 contatos.at(i).numero = contato.numero;
			 contatos.at(i).nome = contato.nome;
			 cout << "\nContato editado com sucesso!\n"<< endl;
			return;
			};
	};
	cout << "\nNão foi possível encontrar o contato.\n"<< endl;
	
};	
void listaContatos(){
	for(int i = 0; i < contatos.size() ; i++){
		cout << "Nome: " <<contatos.at(i).nome << endl;
		cout << "Número: " <<contatos.at(i).numero << endl;
	};
  
}
void chamarContato(Contato contato){
	for (int i = 0; i < contatos.size() ; i++) {
		if (contatos.at(i).nome == contato.nome) {
			contatos.at(i).contaChamadas++;
		}
	}
};


void adicionarGrupos(Contato contato){

};

void menuContato(Contato contato){
	string opcao;
	
	cout << "Digite uma opção:";
	cin >> opcao;
	switch(opcao[0]){
		  case '1':
			editarContato(contato);
			break;
		  case '2':
			chamarContato(contato);
			break;
		  case '3':
			//Adicionar aos favoritos
			break;
		  case '4':
			adicionarGrupos(contato);
			break;
		  default:
		    cout << "\nOpção Inválida\n" << endl;
		    break;
		
};	
};	

void buscaContato(string &nome){
	Contato contato;
	bool achou = false;
	
	for (int i = 0; i < contatos.size() ; i++) {
		if (contatos.at(i).nome == nome) {
			contato = contatos.at(i);
			achou = true;
			break;
		}
	}
	
	if(achou){
		cout << "Nome: " <<contato.nome << endl;
		cout << "Número: " <<contato.numero << endl;
		printMenuContato();
		menuContato(contato);
		
	} else {
		cout << "\nContato não encontrado.\n";
	}

};


int main(){	

	printMenu();
	string opcao;
	cin >> opcao;
	string nomeBusca;
	switch(opcao[0]){
		  case '1':
			addContato();
			cout<< "\nContato adicionado com sucesso!\n"<< endl;
			break;
		  case '2':
			deleteContato();
			
			break;
		  case '3':
			cout << "\nTodos os contatos: " << endl;
			listaContatos();
			break;
		  case '4':
			cout << "Nome do contato:";
			cin >> nomeBusca;
			buscaContato(nomeBusca);
			break;
		  default:
		    cout << "\nOpção Inválida\n" << endl;
		    break;
		
     }; 
			  
     main();
}
	
	
	
