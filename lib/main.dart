import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC',
      home: TelaPrincipal(),
    ),
  );
}

//
// TELA PRINCIPAL
// Stateful = stf+TAB
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Declaração de atributos que serão utilizados
  //para receber os dados que o usuário digitar
  //no campo de texto
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();

  //Declaração do atributo que identifica
  //unicamente o formulário
  var f1 = GlobalKey<FormState>();

  @override
  void initState() {
    //definir o valor inicial da variável
    //txtPeso.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BARRA TÍTULO
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.green.shade900,
      ),
      backgroundColor: Colors.grey.shade100,
      //BODY
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              //identificador do form
              key: f1,
              child: Column(
                children: [
                  const Icon(
                    Icons.people_alt,
                    size: 100,
                    color: Color.fromRGBO(27, 94, 32, 1),
                  ),
                  campoTexto('Peso', txtPeso),
                  const SizedBox(height: 20),
                  campoTexto('Altura', txtAltura),
                  const SizedBox(height: 30),
                  botao('calcular'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
  campoTexto(rotulo, variavel) {
    return TextFormField(
      //associar a variável que receberá o valor
      //digitado no campo de texto
      controller: variavel,
      //habilitar o teclado numérico
      keyboardType: TextInputType.number,
      //campo de senha
      obscureText: false,
      //número de caracteres
      maxLength: 10,
      //definir o campo de texto somente leitura
      //readOnly: true,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(27, 94, 32, 0.5),
        ),
        hintText: 'Informe o valor',
        hintStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(27, 94, 32, 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      //
      // Validação dos Dados
      //
      validator: (value) {
        value = value!.replaceFirst(',', '.');
        if (double.tryParse(value) == null) {
          return 'Entre com um valor numérico';
        }
      },
    );
  }

  //
  // BOTÃO
  //
  botao(rotulo) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        //Evento que ocorrerá quando o usuário acionar
        //o botão
        onPressed: () {
          
          if (f1.currentState!.validate()){

            //Recuperar os dados informados pelo usuário
            setState(() {
              double p = double.parse(txtPeso.text.replaceFirst(',', '.'));
              double a = double.parse(txtAltura.text.replaceFirst(',', '.'));
              double i = p / pow(a, 2);
              caixaDialogo(
                  'O valor do IMC é ${i.toStringAsFixed(2).replaceFirst('.', '.')}');
            });

          }

          

        },
        child: Text(
          rotulo,
          style: const TextStyle(fontSize: 22),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green.shade400,
        ),
      ),
    );
  }

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('fechar')),
            ],
          );
        });
  }
}
