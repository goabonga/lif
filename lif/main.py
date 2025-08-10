import torch
import matplotlib.pyplot as plt
from lif_lsm import lif_lsm
from train_readout import train_readout
import matplotlib

matplotlib.use('TkAgg')

# Paramètres
N_in = 1
N_res = 100
N_out = 1
T = 500

params = {
    "tau_m": 10.0,
    "dt": 1.0,
    "V_th": 1.0,
    "V_reset": 0.0,
    "t_ref": 5.0,
    "N_out": N_out,
}

# Poids
W_in = torch.randn(N_res, N_in) * 0.5
W_res = torch.randn(N_res, N_res) * 0.05

# Entrée (pulses)
t = torch.arange(T)
input_signal = ((t % 50) < 2).float().unsqueeze(0)

# Cible = sinusoïde
target = torch.sin(2 * torch.pi * t.float() / 100).unsqueeze(0)

# Simulation sans readout
spikes, _ = lif_lsm(input_signal, W_in, W_res, None, params)

# Entraînement
W_out = train_readout(spikes, target, lmbd=1e-3)

# Réexécution avec readout appris
_, output = lif_lsm(input_signal, W_in, W_res, W_out, params)

# Affichage
plt.plot(t, target.squeeze(), 'k--', label="Target")
plt.plot(t, output.squeeze(), 'b', label="LSM Output")
plt.legend()
plt.title("LSM trained on sin(t)")
plt.xlabel("Time")
plt.ylabel("Value")
plt.grid(True)
plt.tight_layout()
plt.show()
