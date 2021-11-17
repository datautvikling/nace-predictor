# Train NACE predictor with Debian GNU/linux 10

# Install linux packages and Python
sudo apt-get update && sudo apt-get install -yq git supervisor python3 python3-pip python3-venv python3-wheel
sudo pip3 install --upgrade pip

# Download source code
git clone https://github.com/datautvikling/nace-predictor.git && cd nace-predictor

# Setup Python environment
python3 -m venv env-training && source env-training/bin/activate
pip3 install -r training-util/requirements.txt

# Train model
python3 training-util/training-util.py