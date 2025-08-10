# LIF LSM Project

## Overview

This project implements a Liquid State Machine (LSM) using Leaky Integrate-and-Fire (LIF) neurons. The LSM is a type of spiking neural network that is used for processing temporal data. It consists of a reservoir of spiking neurons and a readout layer that is trained to produce the desired output.

## Project Structure

- `lif_lsm.m`: MATLAB implementation of the LIF LSM.
- `train_readout.m`: MATLAB function for training the readout layer using ridge regression.
- `pyproject.toml`: Configuration file for the Python project.
- `poetry.toml`: Configuration for Poetry virtual environments.
- `main.o`: MATLAB script for running the LSM simulation and training the readout layer.
- `lif/main.py`: Python script for running the LSM simulation and training the readout layer.
- `lif/lif_lsm.py`: Python implementation of the LIF LSM.
- `lif/train_readout.py`: Python function for training the readout layer using ridge regression.

## Dependencies

The project requires Python 3.13 or higher and the following Python packages:

- `torch`: For tensor operations and neural network components.
- `matplotlib`: For plotting and visualization.

## Installation

1. Clone the repository:

   ```
   git clone https://github.com/yourusername/lif-lsm.git
   cd lif-lsm
   ```

2. Install dependencies using Poetry:

   ```
   poetry install
   ```

3. Activate the virtual environment:

   ```
   poetry shell
   ```

## Usage

### Python

1. Run the main script to simulate the LSM and train the readout layer:

   ```
   python lif/main.py
   ```

2. The script will display a plot comparing the target output and the LSM output.

### MATLAB

1. Open `main.o` in MATLAB.

2. Run the script to simulate the LSM and train the readout layer.

3. The script will display a plot comparing the target output and the LSM output.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Author

Chris - goabonga@pm.me
