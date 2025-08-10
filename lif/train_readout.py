import torch

def train_readout(spikes: torch.Tensor, target: torch.Tensor, lmbd: float) -> torch.Tensor:
    X = spikes.T  # [T, N_res]
    Y = target.T  # [T, N_out]

    XtX = X.T @ X
    reg = lmbd * torch.eye(XtX.size(0))
    W_out = (XtX + reg).inverse() @ X.T @ Y
    return W_out.T  # [N_out, N_res]
