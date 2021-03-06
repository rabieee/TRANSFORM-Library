within TRANSFORM.Fluid.Volumes;
model ExpansionTank "Expansion tank with cover gas"

  extends TRANSFORM.Fluid.Interfaces.Records.Medium_fluid;
  //   package Medium = Modelica.Media.Water.StandardWater (extraPropertiesNames={"CO2"},
  //         C_nominal={1.519E-1});

  import Modelica.Fluid.Types.Dynamics;

  parameter SI.Area A "Cross-sectional area";
  parameter SI.Volume V0=0 "Volume at zero level";
  input SI.Pressure p_surface=p_start "Liquid surface/gas pressure" annotation(Dialog(group="Input Variables"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction"
    annotation (Dialog(tab="Advanced"));
  parameter SI.Pressure p_start = 1e5 annotation(Dialog(tab="Initialization"));
  parameter SI.Length level_start "Start level"
    annotation (Dialog(tab="Initialization"));
  parameter SI.SpecificEnthalpy h_start=1e5
    annotation (Dialog(tab="Initialization"));
  parameter Dynamics massDynamics=Dynamics.DynamicFreeInitial
    "Formulation of mass balances"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics traceDynamics=massDynamics
    "Formulation of trace substance balances"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));

  parameter SI.MassFraction X_start[Medium.nX]=Medium.X_default "Mass fraction"
    annotation (Dialog(
      tab="Initialization",
      group="Start Value: Species Mass Fraction",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction C_start[Medium.nC]=fill(0, Medium.nC)
    "Mass fraction" annotation (Dialog(
      tab="Initialization",
      group="Start Value: Trace Substances Mass Fraction",
      enable=Medium.nC > 0));

  constant Real g_n=Modelica.Constants.g_n;

  Medium.ThermodynamicState state_liquid "Thermodynamic state of the liquid";
  SI.Length level(start=level_start, stateSelect=StateSelect.prefer)
    "Liquid level";
  SI.Volume V "Liquid volume";
  SI.Mass m "Liquid mass";
  SI.InternalEnergy U "Liquid internal energy";
  Medium.SpecificEnthalpy h(start=h_start, stateSelect=StateSelect.prefer)
    "Liquid specific enthalpy";
  Medium.AbsolutePressure p(start=p_start) "Bottom pressure";
  SI.Mass mXi[Medium.nXi] "Species mass";
  SI.Mass mC[Medium.nC] "Trace substance mass";
  SI.MassFraction Xi[Medium.nXi](start=Medium.reference_X[1:Medium.nXi])
    "Structurally independent mass fractions";
  SI.MassFraction C[Medium.nC](stateSelect=StateSelect.prefer, start=C_start)
    "Trace substance mass fraction";

  // Species Balance
  SI.MassFlowRate mXib[Medium.nXi]
    "Species mass flow rates source/sinks within volumes";

  // Trace Balance
  SI.MassFlowRate mCb[Medium.nC]
    "Trace mass flow rate source/sinks within volumes (e.g., chemical reactions, external convection)";

  TRANSFORM.Fluid.Interfaces.FluidPort_State port_a(
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=h_start),
    p(start=Medium.density(Medium.setState_phX(p_start, h_start))*g_n*
          level_start + p_start))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-80,-80},{-40,-40}}, rotation=
           0), iconTransformation(extent={{-70,-70},{-50,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=h_start),
    p(start=Medium.density(Medium.setState_phX(p_start, h_start))*g_n*
          level_start + p_start))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{40,-80},{80,-40}}, rotation=0),
        iconTransformation(extent={{50,-70},{70,-50}})));

initial equation

  if massDynamics == Dynamics.FixedInitial then
    h = h_start;
    level = level_start;
    Xi = X_start[1:Medium.nXi];
  elseif massDynamics == Dynamics.SteadyStateInitial then
    der(h) = 0;
    der(level) = 0;
    der(Xi) = zeros(Medium.nXi);
  end if;

  // Trace Balance
  if traceDynamics == Dynamics.FixedInitial then
    C = C_start;
  elseif traceDynamics == Dynamics.SteadyStateInitial then
    der(mC) = zeros(Medium.nC);
  end if;

equation
  // Set liquid properties
  state_liquid = Medium.setState_phX(p_surface, h);

  V = V0 + A*level;
  m = V*Medium.density(state_liquid);
  U = m*Medium.specificInternalEnergy(state_liquid);
  p - p_surface = Medium.density(state_liquid)*g_n*level;
  mC = m*C;

  if massDynamics == Dynamics.SteadyState then
    der(m) = 0;
    der(U) = 0;
  else
    der(m) = port_a.m_flow + port_b.m_flow;
    der(U) = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*
      actualStream(port_b.h_outflow);
  end if;

  // Species Balance
  if massDynamics == Dynamics.SteadyState then
    zeros(Medium.nXi) = mXib;
  else
    der(mXi) = mXib;
  end if;

  // Trace Balance
  if traceDynamics == Dynamics.SteadyState then
    zeros(Medium.nC) = mCb;
  else
    der(mC) = mCb;
  end if;

  for i in 1:Medium.nXi loop
    mXib[i] = port_a.m_flow*actualStream(port_a.Xi_outflow[i]) + port_b.m_flow*
      actualStream(port_b.Xi_outflow[i]);
  end for;
  for i in 1:Medium.nC loop
    mCb[i] = port_a.m_flow*actualStream(port_a.C_outflow[i]) + port_b.m_flow*
      actualStream(port_b.C_outflow[i]);
  end for;

  port_a.h_outflow = h;
  port_b.h_outflow = h;
  port_a.p = p;
  port_b.p = p;

  for i in 1:Medium.nXi loop
    port_a.Xi_outflow[i] = Xi[i];
    port_b.Xi_outflow[i] = Xi[i];
  end for;

  for i in 1:Medium.nC loop
    port_a.C_outflow[i] = C[i];
    port_b.C_outflow[i] = C[i];
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(extent={{-100,-105},{100,-120}}, textString="%name"),
        Ellipse(
          extent={{-85,85},{85,-85}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Sphere,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-85,-85},{85,85}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={170,255,255},
          fillPattern=FillPattern.Sphere,
          startAngle=0,
          endAngle=180),
        Text(
          extent={{-100,50.5},{100,30}},
          lineColor={64,64,64},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Cover Gas")}), Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}})));
end ExpansionTank;
