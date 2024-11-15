
# Todo_list_project

## O projeto

Esse projeto tem como base desenvolvimento em aplicações Flutter, tendo como tema um aplicativo de uma bloco de tarefas feito com registros diarios, semanais e mensal, para fazer as tarefas!

use de Back-end no Firebase e sqlite!

dependencias usadas:
- flutter_localizations:
    sdk: flutter

-   provider: ^6.1.2
-   sqflite: ^2.4.0
-   path: ^1.9.0
-   google_fonts: ^6.2.1
-   sign_in_button: ^3.2.0
-   firebase_core: ^3.6.0
-   firebase_auth: ^5.3.1
-   validatorless: ^1.2.3
-   flutter_overlay_loader: ^2.0.0
-   google_sign_in: ^6.2.1
-   date_picker_timeline: ^1.2.6
-   intl: ^0.19.0

### pontos importantes para melhorar

- metodo contains retorna sempre uma lista vazia no firebase então os metodos de register e login ainda não funcionam. (*Resolução: Desativar a proteção contra enumeração de e-mails, porem abre brechas de segurança.*)

- criar pagina de recuperar senha e separar o recuperar senha do login

- Quando o usuario sai da sua conta, e loga novamente, todas as suas tarefas são deletadas;

- Adicionar lembrete das tarefas no dia em uma notificação;

# IMPORTANTE:

CASO USE ESTE PROJETO, IMPORTAR O ARQUIVO *google-services.json* DO FIREBASE

