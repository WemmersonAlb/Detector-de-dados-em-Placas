%  Script de reconhecimento de objetos na imagem
%  Minicurso de Visão Computacional
%  Aluno: Wemmerson Albuquerque
%  Data: 14/04/2023


%  Recebe a imagem, a torna cinza e binariza
placa = imread('placa.bmp');

grayPlaca = im2gray(placa);

binPlaca = imbinarize(grayPlaca, "global");


%  Calcula a quantidade de branco, inverte,
%  calcula novamente a quantidade de branco e armazena
somaBranco1 = sum(sum(binPlaca));
binPlaca = ~binPlaca;
somaBranco2 =sum(sum(binPlaca));

%  Verifica qual a versão com menos branco
%  pois brancos são os objetos
if(somaBranco1<somaBranco2)
    binPlaca = ~binPlaca;
end




%  Divide a imagem em objetos pelas bordas
%  e conta quantos objetos existem
label = bwlabel(binPlaca);
qtd = max(max(label));


%  Calcula a quantidade de pixeis da largura de um objeto
[j,i]=find(binPlaca==1);
jI = min(j);
jF = max(j);
width = jF-jI

%  Cria um padrão para o tamanho mínimo de nosso objeto alvo
padraoMin = sum(sum(binPlaca))*0.05;

%  Laço que percorre o array de objetos
for i=1:1:qtd
    %  Coloca o objeto da vez na variável auxiliar
    aux = label == i;
    
    %  Calcula o tamanho do objeto da vez e 
    %  detecta seus limites
    tam = sum(sum(aux));
    [x,y] = find(aux == 1);

    xI = min(x);
    xF = max(x);
    yI = min(y);
    yF = max(y);
    
    %  Calcula a largura do objeto da vez
    widthAux = xF-xI

    %  Exibe o objeto da vez somente se ele tiver as 
    %  caracteristicas de nosso objeto alvo
    if(tam>padraoMin && widthAux<(width*0.6))      
        caractere = aux(xI-1:xF+1,yI-1:yF+1);
        imshow(caractere);
    end
end



