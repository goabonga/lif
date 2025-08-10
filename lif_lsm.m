function [spike_train, output] = lif_lsm(input_signal, W_in, W_res, W_out, params)
  N = size(W_res, 1);       % nombre de neurones dans le réservoir
  steps = size(input_signal, 2);

  % États initiaux
  V = zeros(N, 1);          % potentiel membrane
  spike_train = zeros(N, steps);
  output = zeros(size(W_out, 1), steps);
  refractory_time = zeros(N, 1); % temps restant avant désactivation du neurone

  % Paramètres
  tau_m = params.tau_m;     % constante de fuite (ms)
  dt = params.dt;           % pas de temps (ms)
  V_th = params.V_th;       % seuil
  V_reset = params.V_reset; % potentiel après spike
  t_ref = params.t_ref;     % période réfractaire

  for t = 1:steps
    u_t = input_signal(:, t);

    % Neurones actifs (pas en période réfractaire)
    active = refractory_time <= 0;

    % Mise à jour du potentiel
    I_t = W_in * u_t + W_res * spike_train(:, max(t - 1, 1));
    dV = (-V + I_t) / tau_m * dt;
    V(active) += dV(active);

    % Détection des spikes
    spiking = V >= V_th;
    spike_train(spiking, t) = 1;
    V(spiking) = V_reset;
    refractory_time(spiking) = t_ref;

    % Mise à jour de la période réfractaire
    refractory_time -= dt;

    % Readout
    output(:, t) = W_out * spike_train(:, t);
  end
end
