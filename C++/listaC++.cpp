#include <bits/stdc++.h>
#include <map>
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
	contato.nome = nome;
	contato.numero = numero;
	contato.favorito = 0;
	contato.bloqueado = 0;
	contato.contaChamadas = 0;
	
	return contato;
};

void printMenu(){
    printf("%s\n","------ Lista Telefonica topzera ------");
    printf("%s\n", "Opções: ");
    printf("%s\n", "1. Adicionar contato.");
	printf("%s\n", "2. Listar contatos.");
	printf("%s\n", "3. Busca contato.");
	printf("%s\n", "4. Listar por Grupo.");
	printf("%s\n", "8. Sair");
	cout << "Digite sua opção: ";
};

void printMenuContato(){
	printf("%s\n","------ Opcões Contato ------");
    printf("%s\n", "Opções: ");
    printf("%s\n", "1. Editar Contato");
    printf("%s\n", "2. Chamar");
    printf("%s\n", "3. Adcionar aos Favoritos");
    printf("%s\n", "4. Adicionar à Grupo");
    printf("%s\n", "5. Excluir contato.");
    printf("%s\n", "6. Bloquear contato");
}

void printMenuEditarContato(){
    printf("%s\n","------   Contato  ------");
    printf("%s\n", "Opções: ");
    printf("%s\n","1. Modificar o nome.");
	printf("%s\n","2. Modificar o número.");
	printf("%s\n","3. Alterar grupo.");
	cout << "Digite sua opção: ";
};

void addContato(){
  regex r("\\([[:digit:]]{2}\\)[[:digit:]]{1}-[[:digit:]]{4}-[[:digit:]]{4}");
  regex s("\\([[:digit:]]{2}\\)[[:digit:]]{4}-[[:digit:]]{4}");
	string nome;
	string numero;
	Contato novoContato;
	cout << "Nome do contato: ";
	cin.ignore();
	getline(std::cin, nome);

	cout << "Numero do contato((xx)x-xxxx-xxxx ou (xx)xxxx-xxxx): ";
	cin>> numero;
	if (regex_match(numero, r) | regex_match(numero, s)) {
	  novoContato = criaContato(nome, numero);
	  contatos.push_back(novoContato);
	} else {
	  cout << "\nFormato Inválido: Insira dados válidos \n";
	  addContato();
	}
};

void deleteContato(){
	cout<< "Para confirmar, digite o nome do contato que deseja excluir: "<< endl;
	string nome;
	cin.ignore();
	getline(cin, nome);
	
	for(int i = 0; i < contatos.size(); i++){
			if(contatos.at(i).nome == nome){
				contatos.erase(contatos.begin()+ i);
				cout<< "\nContato deletado com sucesso!\n" <<endl;
				break;
			};
	}	
};

void bloqueiaContato(string nome) {
	int posicaoContato = -1;

	for(int i = 0; i < contatos.size(); i++) {
		if (contatos.at(i).nome == nome) {
			posicaoContato = i;
			break;
		}
	}

	if (posicaoContato != -1) {
		string confirmaContato;
		cout << "Para confirmar, digite o nome do contato que deseja bloquear: ";
		cin.ignore();
		getline(cin, confirmaContato);

		if (confirmaContato == nome) {
			contatos.at(posicaoContato).bloqueado = 1;
			cout << "\n" << endl;
			cout << "Contato bloqueado com sucesso!" << endl;
		}

	} else {
		cout << "Contato nao existe!" << endl;
	}
};

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

/**
* Atualiza um contato na lista de contatos.
**/
void editarContatoGenerico(Contato contatoRecebido){
	Contato contato;
	for(int i = 0; i < contatos.size() ; i++){
		if(contatos.at(i).nome == contatoRecebido.nome){
			 contatos.at(i).numero = contatoRecebido.numero;
			 contatos.at(i).nome = contatoRecebido.nome;
			 contatos.at(i).grupos = contatoRecebido.grupos;
			 cout << "\nContato editado com sucesso!\n"<< endl;
			return;
			};
	};
	cout << "\nNão foi possível encontrar o contato.\n"<< endl;
	
};	

void listaContatos(){
	for(int i = 0; i < contatos.size() ; i++){
		Contato contato = contatos.at(i);

		cout << "Nome: " << contato.nome << endl;
		cout << "Número: " << contato.numero << endl;
		cout << "Bloqueado? ";
		if (contato.bloqueado == 0) cout << "Nao" << endl;
		else cout << "Sim" << endl;
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
	string grupo;
	printf("Digite o nome do grupo: (ex: Faculdade, Família): ");
	cin.ignore();
	cin >> grupo;
	contato.grupos.push_back(grupo);
	editarContatoGenerico(contato);
	printf("Pronto :)\n");

	// for (int i = 0; i < contatos.size(); ++i) {
	// 	for(int j = 0; j < contatos.at(i).grupos.size(); ++j){
	// 		cout << contatos.at(i).grupos.at(j);
	// 		printf("\n");
	// 	}
	// }
	cin.ignore();
};

/**
* Verifica se o contato faz parte de um grupo específico
* returns {Boolean} true caso o contato esteja nesse grupo.
**/
bool isContatoInGrupoEspecifico(Contato contato, string grupo){
	vector<string> grupos = contato.grupos;
	for (int i = 0; i < contato.grupos.size(); ++i) {
		if(contato.grupos.at(i).compare(grupo) == 0) return true;
	}
	return false;
}

/**
*	Filtra a lista de contatos para aqueles que estão em um grupo específico.
*/
void listaPorGrupo(string nomeGrupo){
	for(int i = 0; i < contatos.size() ; i++){
		if (isContatoInGrupoEspecifico(contatos.at(i), nomeGrupo)){
			cout << "Nome: " <<contatos.at(i).nome << endl;
			cout << "Número: " <<contatos.at(i).numero << endl;
		}
	};
}

void menuContato(Contato contato){
	string opcao;
	
	cout << "Digite uma opção: ";
	cin >> opcao;
	string nomeContato;
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
		  case '5':
			deleteContato();
			break;
		  case '6':
		  	cout << "Nome contato: ";
		  	cin >> nomeContato;
		  	bloqueiaContato(nomeContato);
		  	break;
		  default:
		    cout << "\nOpção Inválida\n" << endl;
		    break;
		
	};
};

void buscaContato(string nome){
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
	bool leave = false;
	string opcao;
	cin >> opcao;
	string nomeBusca;
	switch(opcao[0]){
		  case '1':
			addContato();
			cout<< "\nContato adicionado com sucesso!\n"<< endl;
			break;
		  case '2':
			cout << "\nTodos os contatos: " << endl;
			listaContatos();
			break;
		  case '3':
			cout << "Nome do contato: ";
			cin.ignore();
			getline(cin, nomeBusca);
			buscaContato(nomeBusca);
			break;	
			
			case '4':
				cout << "Nome do grupo:";
				cin >> nomeBusca;
				listaPorGrupo(nomeBusca);
				break;
			case '8':
		    leave = true;
		    break;
		  default:
		    cout << "\nOpção Inválida\n" << endl;
		    break;
		
     }; 
			  
    if (leave) cout << "Xau, perua" << endl;
    else main();
}
	
	
	
