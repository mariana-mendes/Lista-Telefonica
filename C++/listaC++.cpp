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
	printf("%s\n","5. Busca contato.");
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
			 cout << "\nContato editado com sucesso!\n"<< endl;
			return;
			};
	};
	cout << "\nNão foi possível encontrar o contato.\n"<< endl;
	
};

void buscaContato(){
	cout << "Nome do contato:";
	string nome;
	cin >> nome;
	Contato contato;
	bool achou = false;
	
	for (int i = 0; i < contatos.size() ; i++) {
		if (contatos.at(i).nome == nome) {
			contato = contatos.at(i);
			achou = true;
		}
	}
	
	if  (achou == true){
		cout << "Nome: " <<contato.nome << endl;
		cout << "Número: " <<contato.numero << endl;
	} else {
		cout << "\nContato não encontrado.\n";
	}

};


int main(){	

	printMenu();
	string opcao;
	cin >> opcao;
	switch(opcao[0]){
		  case '1':
			addContato();
			cout<< "\nContato adicionado com sucesso!\n"<< endl;
			break;
		  case '2':
			deleteContato();
			cout << "\nExcluído com sucesso!\n" <<endl;
			break;
		  case '3':
			cout << "\nTodos os contatos: " << endl;
			listaContatos();
			break;
		  case '4':
			procuraContato();
			break;
		  case '5':
			buscaContato();
			break;
		  default:
		    cout << "\nOpção Inválida\n" << endl;
		    break;
		
     }; 
			  
     main();
}
	
	
	
