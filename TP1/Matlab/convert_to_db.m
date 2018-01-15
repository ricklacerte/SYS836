function v_gain_db = convert_to_db(v_gain)
  %Converting to dB
  % v_gain : vector of gain value (ratio)
  % v_gain_db : vector of gain expressed in dB
  v_gain_db=10*log(v_gain);

end