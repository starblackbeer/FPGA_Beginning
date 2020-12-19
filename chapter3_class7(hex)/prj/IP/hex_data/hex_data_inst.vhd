	component hex_data is
		port (
			source : out std_logic_vector(31 downto 0)   -- source
		);
	end component hex_data;

	u0 : component hex_data
		port map (
			source => CONNECTED_TO_source  -- sources.source
		);

