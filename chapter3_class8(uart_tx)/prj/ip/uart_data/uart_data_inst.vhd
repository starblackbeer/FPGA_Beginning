	component uart_data is
		port (
			probe  : in  std_logic_vector(0 downto 0) := (others => 'X'); -- probe
			source : out std_logic_vector(7 downto 0)                     -- source
		);
	end component uart_data;

	u0 : component uart_data
		port map (
			probe  => CONNECTED_TO_probe,  --  probes.probe
			source => CONNECTED_TO_source  -- sources.source
		);

