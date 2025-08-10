function W_out = train_readout(spike_train, target_output, lambda)
  % spike_train : [N_res x T]
  % target_output : [N_out x T]
  % lambda : régularisation ridge (ex: 1e-3)

  X = spike_train';            % [T x N_res]
  Y = target_output';          % [T x N_out]

  % Régression ridge : W = (XᵀX + λI)⁻¹ XᵀY
  XtX = X' * X;
  N = size(XtX, 1);
  W_out = ((XtX + lambda * eye(N)) \ (X' * Y))'; % [N_out x N_res]
end

