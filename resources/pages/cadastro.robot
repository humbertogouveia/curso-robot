*** Settings ***
Resource    ../main.robot

*** Variables ***
${URL}                    http://localhost:3000/
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
${BOTAO_CARD}             id:form-botao
${ERRO_NOME}              id:form-nome-erro
${ERRO_CARGO}             id:form-cargo-erro   
${ERRO_TIMES}             id:form-times-erro
@{selecionar_times}
...    //option[contains(.,'Programação')]
...    //option[contains(.,'Front-End')]
...    //option[contains(.,'Data Science')]
...    //option[contains(.,'Devops')] 
...    //option[contains(.,'UX e Design')]
...    //option[contains(.,'Mobile')]
...    //option[contains(.,'Inovação e Gestão')]


*** Keywords ***

Dado que preencha os campos do formulário
    ${Nome}        FakerLibrary.First Name
    ${Cargo}       FakerLibrary.Job
    ${Imagem}      FakerLibrary.Image Url

    Input Text    ${CAMPO_NOME}    ${Nome}
    Input Text    ${CAMPO_CARGO}   ${Cargo}
    Input Text    ${CAMPO_IMAGEM}  ${Imagem}

    Click Element  ${CAMPO_TIME}
    Click Element  ${selecionar_times}[0]
E clique no botão criar card
    Click Element    ${BOTAO_CARD}
Então identifico o cargo no time esperado
    #Sleep    3s
    Element Should Be Visible    class:colaborador

Então identico 3 cards no time esperado
    FOR    ${i}    IN RANGE    1    3    
        Dado que preencha os campos do formulário
            E clique no botão criar card

    END

Então criar e identificar 1 card em cada time disponível
    FOR    ${index}    ${time}    IN ENUMERATE    @{selecionar_times}
        Dado que preencha os campos do formulário
        Click Element    ${time}
        E clique no botão criar card        
    END

Dado que eu clique no botão criar card
   Click Element    ${BOTAO_CARD}   

Então sistema deve apresentar mensagem de campo obrigatório
    Element Should Be Visible    ${ERRO_NOME}             
    Element Should Be Visible    ${ERRO_CARGO}
    Element Should Be Visible    ${ERRO_TIMES}             

