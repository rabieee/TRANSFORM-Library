within TRANSFORM.HeatAndMassTransfer.FinEfficiency;
model GenericFin
  import Modelica.Math.tanh;

  extends
    TRANSFORM.HeatAndMassTransfer.FinEfficiency.BaseClasses.PartialFinEfficiency;

  parameter Boolean use_NonDimensional = false "=true then specify mL)";
  parameter Boolean use_adiabaticTip = true "=true then use adiabatic tip solution else convective tip";

  input SI.CoefficientOfHeatTransfer alpha "Average heat transfer coefficient" annotation(Dialog(group="Input Variables",enable=not use_NonDimensional));
  input SI.ThermalConductivity lambda "Thermal conductivity" annotation(Dialog(group="Input Variables",enable=not use_NonDimensional));
  input SI.Length perimeter "Fin perimeter" annotation(Dialog(group="Input Variables",enable=not use_NonDimensional));
  input SI.Length L "Fin length" annotation(Dialog(group="Input Variables",enable=not use_NonDimensional));
  input SI.Area crossArea "Fin cross-sectional area" annotation(Dialog(group="Input Variables",enable=not use_NonDimensional));

  input Units.nonDim mL = sqrt(perimeter*alpha/(lambda*crossArea))*L "Non-dimensional fin parameter" annotation(Dialog(group="Input Variables",enable=use_NonDimensional));

  SI.Area surfaceArea = if use_adiabaticTip then perimeter*L else perimeter*L + crossArea;
  Units.nonDim AR_tip = crossArea/(perimeter*L) "Tip area ratio";

algorithm

  if use_adiabaticTip then
    eta :=tanh(mL)/mL;
  else
    eta :=(tanh(mL) + mL*AR_tip)/(mL*(1 + mL*AR_tip*tanh(mL))*(1 + AR_tip));
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(
          extent={{-100,-100},{100,100}},
          fileName=
              "modelica://TRANSFORM/Resources/Images/Icons/GenericAdiabaticFin.jpg",
          visible=DynamicSelect(true, use_adiabaticTip)),
          Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/GenericConvectiveFin.jpg",visible=DynamicSelect(false, not use_adiabaticTip))}),
        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GenericFin;
