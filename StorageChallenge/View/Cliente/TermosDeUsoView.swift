
import SwiftUI

struct TermosDeUsoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Informações Gerais")
                    .font(.title3)
                    .bold()
                
                Text("""
                Ao utilizar a aplicação Swedle, você concorda com os termos e condições estabelecidos abaixo. É importante que você leia atentamente este documento, pois ele descreve as regras e responsabilidades ao usar o nosso aplicativo.

                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("1. Descrição do Serviço")
                    .font(.title3)
                    .bold()
                
                Text("""
                A aplicação Swedle tem como objetivo auxiliar costureiros e alfaiates a registrar e gerenciar as medidas de seus clientes para confecção ou ajustes de peças de roupa. O aplicativo permite o armazenamento local de informações, como nome, telefone, foto e medidas corporais dos clientes, e visa facilitar o processo de ajuste e personalização de roupas.

                O uso da aplicação está sujeito aos termos e condições aqui estabelecidos.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("2. Propriedade intelectual")
                    .font(.title3)
                    .bold()
                
                Text("""
                O aplicativo Swedle e todo o conteúdo nele contido, incluindo, mas não se limitando a, textos, gráficos, logotipos, imagens, ícones e software, são de propriedade de seus desenvolvedores ou de seus respectivos proprietários e estão protegidos pelas leis de direitos autorais e outras leis de propriedade intelectual.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("3. Responsabilidades")
                    .font(.title3)
                    .bold()
                
                Text("""
                Ao utilizar a aplicação Swedle, você concorda em:

                Fornecer informações precisas e atualizadas ao registrar os dados de seus clientes.
                Não utilizar a aplicação para fins ilegais ou não autorizados.
                Ser responsável por todas as atividades realizadas em sua conta, incluindo o armazenamento e gerenciamento dos dados dos seus clientes.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("4. Alterações nos Termos")
                    .font(.title3)
                    .bold()
                
                Text("""
                O time de desenvolvimento do Swedle pode, a qualquer momento, alterar os termos e condições descritos neste documento. Alterações significativas serão notificadas aos usuários por meio de uma atualização do aplicativo ou outro meio de comunicação.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("5. Limitação de Responsabilidade")
                    .font(.title3)
                    .bold()
                
                Text("""
                A equipe de desenvolvimento do Swedle não será responsável por:

                Danos diretos ou indiretos resultantes do uso ou incapacidade de uso da aplicação.
                Perda de dados ou informações devido a falhas técnicas ou de segurança.
                Acesso não autorizado ou uso indevido das informações armazenadas localmente no dispositivo do usuário.
                Conteúdos gerados por terceiros ou links externos disponíveis na aplicação.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("6. Alterações nos Termos de Uso")
                    .font(.title3)
                    .bold()
                
                Text("""
                Este Termo de Uso é regido pela legislação brasileira. A estrutura do site ou aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio, programas de computador, banco de dados, arquivos de transmissão e quaisquer outras informações e direitos de propriedade intelectual de Aline Fernanda Ponzani, José Elias Gomes Camargo, Kauê Araujo Pimentel e Matheus da Silva Marini, observados os termos da Lei da Propriedade Industrial (Lei nº 9.279/96), Lei de Direitos Autorais (Lei n° 9.610/98) e Lei do Software (Lei n° 9.609/98), estão devidamente reservados.
                
                Este Termo de Uso não cede ou transfere ao usuário qualquer direito, de modo que o acesso não gera qualquer direito de propriedade intelectual ao usuário, exceto pela licença limitada ora concedida. O uso da plataforma pelo usuário é pessoal, individual e intransferível, sendo vedado qualquer uso não autorizado, comercial ou não-comercial. Tais usos consistirão em violação dos direitos de propriedade intelectual de Aline Fernanda Ponzani, José Elias Gomes Camargo, Kauê Araujo Pimentel e Matheus da Silva Marini, puníveis nos termos da legislação aplicável.

                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }.navigationTitle("Termos de Uso")
//            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    TermosDeUsoView()
}



