within TRANSFORM.Fluid.Pipes_Obsolete.ClosureModels.PumpCharacteristics.Models.Efficiency;
partial model PartialEfficiencyChar
  "Base class for pump efficiency characteristics."

  // Parameters
  replaceable package Medium =
    Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
    annotation(Dialog(tab="Internal Interface"));

  // Inputs provided to heat transfer model
  input Medium.ThermodynamicState state
    "Thermodynamic state" annotation(Dialog(tab="Internal Interface",group="Input Variables:"));

  input SI.MassFlowRate m_flow "Mass flow rate" annotation(Dialog(tab="Internal Interface",group="Input Variables:"));
  input SI.Conversions.NonSIunits.AngularVelocity_rpm N "Pump speed" annotation(Dialog(tab="Internal Interface",group="Input Variables:"));
  input SI.Length diameter "Impeller Diameter" annotation(Dialog(tab="Internal Interface",group="Input Variables:"));

  parameter SI.MassFlowRate m_flow_nominal "Mass flow rate" annotation(Dialog(tab="Internal Interface",group="Nominal Operating Parameters:"));
  parameter SI.Density rho_nominal "Density" annotation(Dialog(tab="Internal Interface",group="Nominal Operating Parameters:"));
  parameter SI.Conversions.NonSIunits.AngularVelocity_rpm N_nominal "Pump speed" annotation(Dialog(tab="Internal Interface",group="Nominal Operating Parameters:"));
  parameter SI.Length diameter_nominal "Impeller Diameter" annotation(Dialog(tab="Internal Interface",group="Nominal Operating Parameters:"));
  parameter SI.PressureDifference dp_nominal "Nominal pressure gain" annotation(Dialog(tab="Internal Interface",group="Nominal Operating Parameters:"));

  final parameter SI.VolumeFlowRate V_flow_nominal = m_flow_nominal/rho_nominal "Nominal volumetric flow rate";
  final parameter SI.Height head_nominal = dp_nominal/(rho_nominal*Modelica.Constants.g_n) "Nominal head";

  parameter Boolean isPump = true "=true then affinity laws for pump else fan";

  SI.Density rho = Medium.density(state) "Density";

  parameter SI.MassFlowRate m_flow_start;
  parameter SI.Pressure p_a_start;
  parameter SI.Pressure p_b_start;
  parameter SI.SpecificEnthalpy h_start;
  final parameter SI.PressureDifference dp_start = p_b_start - p_a_start;
  final parameter SI.Density rho_start = Medium.density_ph(p_b_start,h_start);
  final parameter SI.VolumeFlowRate V_flow_start = m_flow_start/rho_start;
  SI.VolumeFlowRate V_flow(start=V_flow_start) = m_flow/rho "Volumetric flow rate";
  //SI.VolumeFlowRate V_flow = m_flow/rho "Volumetric flow rate";

  SI.Efficiency eta "Efficiency";

equation

  annotation (defaultComponentName="flowCurve",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                             Ellipse(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-64,12},{64,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialEfficiencyChar;
