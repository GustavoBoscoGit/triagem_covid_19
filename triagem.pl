:- dynamic triagem/3.

triagem :-
    format('~n Triagem para covid-19 ~n'),
    repeat,
    nome(Paciente),
    temperatura(Paciente),
    frequencia_Cardiaca(Paciente),
    frequencia_Respiratoria(Paciente),
    pa_Sistolica(Paciente),
    saturacao(Paciente),
    dispineia(Paciente),
    idade(Paciente),
    comorbidade(Paciente),
    responde(Paciente).

/*perguntas*/
nome(Paciente) :-
    format('~ninforme seu nome: '),
    gets(Paciente).

temperatura(Paciente) :-
    format('~ninforme a temperatura: '),
    gets(Temp),
    asserta(triagem(Paciente,temperatura,Temp)).

frequencia_Cardiaca(Paciente) :-
    format('~ninforme a frequencia cardiaca: '),
    gets(FreCard),
    asserta(triagem(Paciente,frequencia_Cardiaca,FreCard)).

frequencia_Respiratoria(Paciente) :-
    format('~ninforme a frequencia respiratoria: '),
    gets(FreResp),
    asserta(triagem(Paciente,frequencia_Respiratoria,FreResp)).

pa_Sistolica(Paciente) :-
    format('~ninforme o pressao arterial sistolica: '),
    gets(PreSis),
    asserta(triagem(Paciente,pa_Sistolica,PreSis)).

saturacao(Paciente) :-
    format('~ninforme a saturacaoacao do oxigenio: (Sa02) : '),
    gets(SaO2),
    asserta(triagem(Paciente,saturacao,SaO2)).

dispineia(Paciente) :-
    format('~nTem dispneia? (sim ou nao) : '),
    gets(Dispn),
    asserta(triagem(Paciente,dispineia,Dispn)).

idade(Paciente) :-
    format('~ninforme a Idade: '),
    gets(Idade),
    asserta(triagem(Paciente,idade,Idade)).

comorbidade(Paciente) :-
    format('~nPossui comorbidades? '),
    format('~nSe sim digite a quantidade, se não digite 0 : '),
    gets(Como),
    asserta(triagem(Paciente,comorbidade,Como)).

salva(P,A) :-
    tell(A),
    listing(P),
    told.

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

responde(Paciente) :-
    condicao(Paciente, Char),
    !,
    format('A condicao de ~w e ~w.~n',[Paciente,Char]).


/*Estado do paciente*/

/*muito grave*/
condicao(Pct, gravissimo) :-
    triagem(Pct,frequencia_Respiratoria,Valor), Valor > 30;
    triagem(Pct,pa_Sistolica,Valor), Valor < 90;
    triagem(Pct,saturacao,Valor), Valor < 95;
    triagem(Pct,dispineia,Valor), Valor = "sim".

/*grave*/
condicao(Pct, grave) :-
    triagem(Pct,temperatura,Valor), Valor > 39;
    triagem(Pct,pa_Sistolica,Valor), Valor >= 90, Valor =< 100;
    triagem(Pct,idade,Valor), Valor >= 80;
    triagem(Pct,comorbidade,Valor), Valor >= 2.

/*medio*/
condicao(Pct, medio) :-
    triagem(Pct,temperatura,Valor), (Valor < 35; (Valor > 37, Valor =< 39));
    triagem(Pct,frequencia_Cardiaca,Valor), Valor >= 100;
    triagem(Pct,frequencia_Respiratoria,Valor), Valor >= 19, Valor =< 30;
    triagem(Pct,idade,Valor), Valor >= 60, Valor =< 79;
    triagem(Pct,comorbidade,Valor), Valor = 1.


/*leve*/
condicao(Pct, leve) :-
    triagem(Pct,temperatura,Valor), Valor >= 35, Valor =< 37;
    triagem(Pct,frequencia_Cardiaca,Valor), Valor < 100;
    triagem(Pct,frequencia_Respiratoria,Valor), Valor =< 18;
    triagem(Pct,pa_Sistolica,Valor), Valor > 100;
    triagem(Pct,saturacao,Valor), Valor >= 95;
    triagem(Pct,dispineia,Valor), Valor = "nao";
    triagem(Pct,idade,Valor), Valor < 60;
    triagem(Pct,comorbidade,Valor), Valor = 0.