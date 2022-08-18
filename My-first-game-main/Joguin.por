programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Mouse --> m
	inclua biblioteca Teclado --> t
	inclua biblioteca Tipos --> tp
	inclua biblioteca Sons --> s
	inclua biblioteca Util --> u
	
	inteiro espinhoX[1000]
	inteiro espinhoY[91]={260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350}
	inteiro xx = 0
	inteiro yx = 250
	inteiro Fundo = g.carregar_imagem("Jogo.jpeg")
	inteiro Fundo2 = g.carregar_imagem("Jogo2.jpeg")
	inteiro persfr = g.carregar_imagem("PerParadoDir.png")
	inteiro perstr = g.carregar_imagem("PerParadoEsq.png")
	inteiro persparado = g.carregar_imagem("PerParadoDir.png")
	inteiro velo = 3
	inteiro gravi = 1
	inteiro velocidade = 0
	inteiro pers_y = 295
	inteiro pers_x = 100
	inteiro persanddir = g.carregar_imagem("PersPassoDirGIF.gif")
	inteiro persandesq = g.carregar_imagem("PersPassoEsqGIF.gif")
	logico antesfr
	logico antestr
	logico personagem_morto = falso	
	inteiro som = s.carregar_som("MusicaJogo.mp3")
	
	funcao fundo(){	
		g.desenhar_imagem(0, 0, Fundo)
		g.desenhar_texto(10, 11, "Aperte ESPAÇO para pular")
		g.desenhar_texto(10, 22, "Aperte 'A' ou <- para ir para esquerda")
		g.desenhar_texto(10, 33, "Aperte 'D' ou -> para ir para direita")
		g.desenhar_texto(10, 44, "Ou ESC para fechar o jogo")
	}

	funcao fundo2(){
		g.desenhar_imagem(0, 0, Fundo2)
		g.desenhar_texto(10, 11, "Aperte ESPAÇO para pular")
		g.desenhar_texto(10, 22, "Aperte 'A' ou <- para ir para esquerda")
		g.desenhar_texto(10, 33, "Aperte 'D' ou -> para ir para direita")
		g.desenhar_texto(10, 44, "Ou ESC para fechar o jogo")
	}

	funcao musica(){
		
		s.reproduzir_som(som, falso)
		s.definir_volume(70)
	}
	
	funcao personagem_andando_direita(){
		g.desenhar_imagem(pers_x, 278, persanddir) 
	}
	
	funcao personagem_andando_esquerda(){
		g.desenhar_imagem(pers_x, pers_y, persandesq)
	}

	funcao personagem_inicial(){
		se(nao (t.tecla_pressionada(t.TECLA_A) ou (t.tecla_pressionada(t.TECLA_SETA_ESQUERDA) ou (t.tecla_pressionada(t.TECLA_D) ou (t.tecla_pressionada(t.TECLA_SETA_DIREITA)))))){
			g.desenhar_imagem(pers_x, pers_y, persparado)
		}
	}

	funcao personagem_inicial_fase2(){
		enquanto(nao (t.tecla_pressionada(t.TECLA_A) ou (nao t.tecla_pressionada(t.TECLA_SETA_ESQUERDA) ou (nao t.tecla_pressionada(t.TECLA_D) ou (nao t.tecla_pressionada(t.TECLA_SETA_DIREITA)))))){
			
			g.desenhar_imagem(pers_x, pers_y, persparado)
		}
	}
	
	funcao controle_tras(){	
		se(t.tecla_pressionada(t.TECLA_A) ou (t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))){
			pers_x = pers_x - velo
			personagem_andando_esquerda()
			antestr = verdadeiro
			antesfr = falso
			u.aguarde(1)
			personagem_antes()
		}	
	}
	
	funcao controle_frente(){		
		se(t.tecla_pressionada(t.TECLA_D) ou (t.tecla_pressionada(t.TECLA_SETA_DIREITA))){
			pers_x  = pers_x + velo
			personagem_andando_direita()
			antesfr = verdadeiro
			antestr = falso
			u.aguarde(1)
			personagem_antes()
		}
	}
		
	funcao pulo(){
		se(t.tecla_pressionada(t.TECLA_ESPACO)){
			pers_y = pers_y - 18 
		}
		gravidade()
	}

	funcao gravidade(){
		velocidade = velocidade + gravi
		pers_y = pers_y + velocidade
		se(pers_y > 295){
			u.aguarde(1)
			pers_y = 300
			velocidade = 0
			velo = 5
		}
	}

	funcao gravidade_buraco(){
		velocidade = velocidade + gravi
		pers_y = pers_y + velocidade
		se(pers_x >= 558){
			u.aguarde(1)
			pers_y = 500
			velocidade = 1
			velo = 5
			personagem_morto=verdadeiro
		}
	}

	funcao personagem_antes(){
		se(nao (t.tecla_pressionada(t.TECLA_D) ou (t.tecla_pressionada(t.TECLA_SETA_DIREITA)))){
			g.desenhar_imagem(pers_x, pers_y, persfr)
		}
		se(nao (t.tecla_pressionada(t.TECLA_A) ou (t.tecla_pressionada(t.TECLA_SETA_ESQUERDA)))){
			g.desenhar_imagem(pers_x, pers_y, perstr)
		}
	}

	funcao espinhos(){
		se(pers_x < (espinhoX[110]) e pers_x >= (espinhoX[1])){
			se(pers_y <= (espinhoY[90]) e (pers_y > (espinhoY[1]))){
				personagem_morto = verdadeiro
			}		
		}
	}

	funcao vetor_espinhosX(){
		para(espinhoX[110] = 360; espinhoX[109] < 360; yx=yx+1){
			espinhoX[xx] = yx + 1
			xx = xx + 1
		}
	}

	funcao animacao_controle_tras(){
		enquanto(t.tecla_pressionada(t.TECLA_A) ou (t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))){
			controle_tras()
			pare
		}
	}

	funcao animacao_controle_frente(){
		enquanto(t.tecla_pressionada(t.TECLA_D) ou (t.tecla_pressionada(t.TECLA_SETA_DIREITA))){
			controle_frente()
			pare
		}
	}

	funcao game_over(){		
		
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(500,400)
		g.definir_titulo_janela("Game over!!!")
		enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
			g.definir_cor(g.COR_VERMELHO)
			g.definir_fonte_texto("Times New Roman")
			g.definir_tamanho_texto(50.0)
			g.desenhar_texto(120,170,"Game over!!!")
			g.definir_cor(g.COR_BRANCO)
			g.definir_fonte_texto("Arial")
			g.definir_tamanho_texto(10.0)
			g.desenhar_texto(270,215,"Aperte ESC para fechar")
			g.renderizar()
		}
		g.fechar_janela()
	}

	funcao buraco(){
		gravidade_buraco()
	}
	
	funcao fase2(){
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Joguin")
		g.definir_dimensoes_janela(1100, 420)
		pers_x = 100
		pers_y = 295
		enquanto(nao personagem_morto){
			//enquanto(nao (t.tecla_pressionada(t.TECLA_A) ou (nao t.tecla_pressionada(t.TECLA_SETA_ESQUERDA) ou (nao t.tecla_pressionada(t.TECLA_D) ou (nao t.tecla_pressionada(t.TECLA_SETA_DIREITA)))))){
			//}
			fundo2()
			musica()
			animacao_controle_frente()
			animacao_controle_tras()
			pulo()
			personagem_antes()
			inteiro Mx = m.posicao_x()
			inteiro My = m.posicao_y()
			buraco()
			g.renderizar()
			
			se(t.tecla_pressionada(t.TECLA_ESC)){
				g.fechar_janela()
			}
		}
	}

	funcao inicio(){	
		//inteiro Som = s.carregar_som("MusicaJogo.mp3")
		
		espinhoX[1] = 250
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Joguin")
		g.definir_dimensoes_janela(1100, 420)
		enquanto(nao personagem_morto){
			s.reproduzir_som(som, falso)
			//s.definir_volume(100)
			personagem_inicial()
			fundo()
			musica()
			vetor_espinhosX()
			espinhos()
			animacao_controle_frente()
			animacao_controle_tras()
			pulo()
			personagem_antes()
			g.renderizar()
			//musica()
			//s.interromper_som(Som)
			se(t.tecla_pressionada(t.TECLA_ESC)){
				g.fechar_janela()
			}
			se(pers_x == (1045)){
				g.minimizar_janela()
				fase2()
			}
		
		}		
		s.interromper_som(som)
		g.limpar()
		game_over()
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6208; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */