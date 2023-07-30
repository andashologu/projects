Update to Spring Security 6.1.2 causes errors on startup:
	fix:
	https://github.com/spring-projects/spring-security/issues/13568
    https://spring.io/security/cve-2023-34035
	https://github.com/spring-projects/spring-security-samples/blob/main/servlet/java-configuration/authentication/preauth/src/main/java/example/SecurityConfiguration.java

    @Bean 
    public SecurityFilterChain securityFilterChain(HttpSecurity http, MvcRequestMatcher.Builder mvc) throws Exception {
        http
            .authorizeHttpRequests((authorize) -> authorize
                .requestMatchers(mvc.pattern("/mvc-endpoint**")).permitAll()
            )
            .csrf((csrf) -> csrf
                .ignoringRequestMatchers(mvc.pattern("/ws/**"))
            )
            ;
        return http.build();
    }
    @Scope("prototype")
	@Bean
	MvcRequestMatcher.Builder mvc(HandlerMappingIntrospector introspector) {
		return new MvcRequestMatcher.Builder(introspector);
	}