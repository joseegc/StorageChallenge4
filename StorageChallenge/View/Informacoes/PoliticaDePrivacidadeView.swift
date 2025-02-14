
import SwiftUI

struct PoliticaDePrivacidadeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("1. Informações Gerais")
                    .font(.title3)
                    .bold()
                
                Text("""
                A presente Política de Privacidade descreve como o aplicativo Swedle coleta, usa, armazena e protege as informações pessoais dos usuários, com o objetivo de garantir total transparência e segurança. Esta política se aplica a todos os usuários do Swedle e esclarece as práticas adotadas em relação à coleta e utilização de dados pessoais no aplicativo.
                
                Este documento foi elaborado em conformidade com a Lei Geral de Proteção de Dados Pessoais (Lei 13.709/18) e outras legislações aplicáveis. O presente termo poderá ser atualizado periodicamente, por isso recomendamos que os usuários revisem esta seção com frequência.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("2. Como São Recolhidos os Dados Pessoais do Usuário")
                    .font(.title3)
                    .bold()
                
                Text("""
                Os dados pessoais dos usuários são recolhidos da seguinte forma:
                Ao adicionar um novo cliente no aplicativo: O usuário pode inserir as seguintes informações do cliente: nome, telefone, foto e medidas corporais (como busto, cintura, quadril, altura, entre outras).
                
                Armazenamento local: Todos os dados fornecidos são armazenados localmente no dispositivo do usuário, sem que haja qualquer compartilhamento desses dados com servidores externos ou terceiros.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("3. Quais Dados Pessoais São Recolhidos?")
                    .font(.title3)
                    .bold()
                
                Text("""
                Os dados pessoais coletados incluem:
                
                Nome do cliente: Para identificar o cliente.
                
                Telefone do cliente: Para que o usuário do aplicativo (o costureiro) possa entrar em contato com o cliente, caso necessário.
                
                Foto do cliente: Para associar visualmente à ficha do cliente.
                
                Medidas corporais do cliente: Informações detalhadas sobre as medidas do corpo do cliente, utilizadas para fazer ajustes nas roupas.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("4. Para Que Finalidades São Utilizados os Dados Pessoais?")
                    .font(.title3)
                    .bold()
                
                Text("""
                Os dados pessoais recolhidos têm as seguintes finalidades:
                
                Armazenamento de informações do cliente: As informações, como nome, telefone, foto e medidas corporais, são utilizadas exclusivamente para o gerenciamento dos dados dos clientes, ajudando o costureiro a criar e ajustar roupas conforme as necessidades de cada cliente.
                
                Facilidade de acesso: Os dados armazenados no dispositivo facilitam o acesso rápido às informações do cliente sempre que necessário.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("5. Por Quanto Tempo os Dados Pessoais São Armazenados?")
                    .font(.title3)
                    .bold()
                
                Text("""
                Os dados pessoais, como nome, telefone, foto e medidas, são armazenados localmente no dispositivo pelo tempo em que o usuário decidir manter as informações. O usuário pode excluir os dados a qualquer momento, diretamente no aplicativo, ou ao remover o aplicativo do dispositivo.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("6. Segurança dos Dados Pessoais Armazenados")
                    .font(.title3)
                    .bold()
                
                Text("""
                São adotadas medidas técnicas e organizativas para proteger os dados pessoais contra acessos não autorizados, destruição, perda, alteração ou divulgação indevida. Isso inclui a proteção de dados armazenados localmente no dispositivo do usuário.
                
                Embora se empenhe em garantir a segurança, não é possível garantir total proteção contra ataques cibernéticos ou acessos não autorizados. O usuário também é responsável por manter a segurança do seu próprio dispositivo, como senhas e configurações de segurança.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("7. Compartilhamento dos Dados")
                    .font(.title3)
                    .bold()
                
                Text("""
                Os dados coletados, como nome, telefone, foto e medidas corporais, são armazenados localmente no dispositivo do usuário e não são compartilhados com terceiros. Não há envio desses dados para servidores externos ou para qualquer outra entidade.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                
                Text("8. Consentimento")
                    .font(.title3)
                    .bold()
                
                Text("""
                Ao utilizar o Swedle, o usuário consente com a coleta e utilização dos seus dados pessoais conforme descrito nesta Política de Privacidade.
                
                O usuário pode, a qualquer momento, revogar seu consentimento. Para isso, deve excluir as informações do cliente diretamente no aplicativo ou remover o aplicativo do dispositivo.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("9. Alterações Para Essa Política de Privacidade")
                    .font(.title3)
                    .bold()
                
                Text("""
                O Swedle reserva-se o direito de modificar esta Política de Privacidade a qualquer momento. Alterações significativas serão notificadas aos usuários por meio de uma atualização no aplicativo.
                
                Ao continuar a utilizar o serviço após as modificações, o usuário estará automaticamente aceitando os novos termos.
                """)
                .font(.callout)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("10. Jurisdição Para Resolução de Conflitos")
                    .font(.title3)
                    .bold()
                
                Text("Este termo será regido pelas leis brasileiras.")
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.bottom, 84)

        }
        .navigationTitle("Política de Privacidade")
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
    }
}

//#Preview {
//    NavigationStack {
//        PoliticaDePrivacidadeView()
//    }
//}
