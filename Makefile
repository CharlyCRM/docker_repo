.PHONY: prepare_venv

prepare_venv:
	@echo "Configurando el entorno de desarrollo..."
	@read -p "Introduce tu nombre de usuario de Git: " git_user; \
	read -p "Introduce tu email de Git: " git_email; \
	git config --global user.name "$$git_user"; \
	git config --global user.email "$$git_email"; \
    git config --global init.defaultBranch main; \
	echo "\nConfigurando SSH para GitHub..."; \
	mkdir -p ~/.ssh; \
	chmod 700 ~/.ssh; \
	echo "\n=== INFORMACIÓN SOBRE TUS CLAVES SSH ==="; \
	echo "Normalmente, tus claves SSH se encuentran en:"; \
	echo "- Windows: C:\\Users\\TuUsuario\\.ssh\\"; \
	echo "- Linux/Mac: ~/.ssh/"; \
	echo "\nPara ver tu clave privada, puedes usar:"; \
	echo "- Windows: type C:\\Users\\TuUsuario\\.ssh\\id_rsa"; \
	echo "- Linux/Mac: cat ~/.ssh/id_rsa"; \
	echo "\nPara ver tu clave pública, puedes usar:"; \
	echo "- Windows: type C:\\Users\\TuUsuario\\.ssh\\id_rsa.pub"; \
	echo "- Linux/Mac: cat ~/.ssh/id_rsa.pub"; \
	echo "\nSi no encuentras tus claves SSH o nunca las has creado, puedes:"; \
	echo "1. Crearlas con: ssh-keygen -t rsa -b 4096"; \
	echo "2. Añadir la clave pública a GitHub: https://github.com/settings/keys"; \
	echo "\n=== INSTRUCCIONES ==="; \
	echo "Por favor, crea un archivo 'config' en el directorio actual y pega:"; \
	echo "1. Tu clave SSH privada (todo el contenido de id_rsa)"; \
	echo "2. En una nueva línea, añade ---PUBKEY---"; \
	echo "3. Tu clave SSH pública (todo el contenido de id_rsa.pub)"; \
	echo "\nEjemplo de formato:"; \
	echo "-----BEGIN OPENSSH PRIVATE KEY-----"; \
	echo "... (contenido de tu clave privada) ..."; \
	echo "-----END OPENSSH PRIVATE KEY-----"; \
	echo "---PUBKEY---"; \
	echo "ssh-rsa AAAA... tu_email@ejemplo.com"; \
	echo "\nCuando hayas terminado, presiona Enter para continuar..."; \
	read dummy; \
	if [ -f "config" ]; then \
		csplit config /---PUBKEY---/; \
		mv xx00 ~/.ssh/id_rsa; \
		mv xx01 ~/.ssh/id_rsa.pub; \
		sed -i '1d' ~/.ssh/id_rsa.pub; \
		chmod 600 ~/.ssh/id_rsa; \
		chmod 644 ~/.ssh/id_rsa.pub; \
		rm -f config; \
		eval $$(ssh-agent -s); \
		ssh-add ~/.ssh/id_rsa; \
		echo "\nClaves SSH configuradas exitosamente."; \
		echo "El archivo temporal 'config' ha sido eliminado."; \
		echo "\nPrueba la conexión con: ssh -T git@github.com"; \
	else \
		echo "\nError: No se encontró el archivo 'config'."; \
		echo "Por favor, crea el archivo con tus claves SSH y vuelve a intentarlo."; \
	fi 