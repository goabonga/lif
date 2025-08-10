import torch
import torch.nn as nn
import matplotlib.pyplot as plt

def lif_lsm(input_signal: torch.Tensor, W_in: torch.Tensor, W_res: torch.Tensor, W_out: torch.Tensor | None, params: dict) -> tuple[torch.Tensor, torch.Tensor]:
    N_res = W_res.size(0)
    T = input_signal.size(1)

    V = torch.zeros(N_res)
    spikes = torch.zeros(N_res, T)
    refractory_time = torch.zeros(N_res)
    output = torch.zeros(params["N_out"], T)

    for t in range(T):
        u_t = input_signal[:, t]
        I_t = W_in @ u_t + W_res @ (spikes[:, max(t - 1, 0)])

        active = refractory_time <= 0
        dV = ((-V + I_t) / params["tau_m"]) * params["dt"]
        V[active] += dV[active]

        spiking = V >= params["V_th"]
        spikes[:, t] = spiking.float()
        V[spiking] = params["V_reset"]
        refractory_time[spiking] = params["t_ref"]

        refractory_time -= params["dt"]

        if W_out is not None:
            output[:, t] = W_out @ spikes[:, t]

    return spikes, output
