within TRANSFORM.Math.Examples.Verification;
model variableFactor

  extends Modelica.Icons.Example;

  constant Real[3] variable_1 = {0.3,0.3,0.4};
  constant Real[5] fixed_1 = {0.2,0.2,0.2,0.2,0.2};
  constant Real[3,5] f_1ans = [1,0.5,0,0,0;
                               0,0.5,1,0,0;
                               0,0,0,1,1];

  constant Real[5] variable_2 = {0.15,0.25,0.15,0.25,0.2};
  constant Real[5] fixed_2 = {0.2,0.2,0.2,0.2,0.2};
  constant Real[5,5] f_2ans = [0.75,0,0,0,0;
                               0.25,1,0,0,0;
                               0,0,0.75,0,0;
                               0,0,0.25,1,0;
                               0,0,0,0,1];

  constant Real[8] variable_3 = {0.1,0.05,0.2,0.2,0.2,0.2,0.2,0.05};
  constant Real[3] fixed_3 = {0.3,0.3,0.4};
  constant Real[8,3] f_3ans = [1,0,0;
                               1,0,0;
                               0.75,0.25,0;
                               0,1,0;
                               0,0.25,0.75;
                               0,0,1;
                               0,0,1;
                               0,0,1];

  constant Real[1] variable_4 = {1.0};
  constant Real[3] fixed_4 = {0.3,0.3,0.4};
  constant Real[1,3] f_4ans = [1,1,1];

  constant Real[3] variable_5 = {0.3,0.3,0.4};
  constant Real[1] fixed_5 = {1.0};
  constant Real[3,1] f_5ans = [1;
                               1;
                               1];

  constant Real[4] variable_6 = {0,0.3,0.3,0.4};
  constant Real[5] fixed_6 = {0.2,0.2,0.2,0.2,0.2};
  constant Real[4,5] f_6ans = [0,0,0,0,0;
                               1,0.5,0,0,0;
                               0,0.5,1,0,0;
                               0,0,0,1,1];

  final parameter Real[3,5] f_1 = TRANSFORM.Math.variableFactor(variable_1, fixed_1) "Factor matrix";
  final parameter Real[5,5] f_2 = TRANSFORM.Math.variableFactor(variable_2, fixed_2) "Factor matrix";
  final parameter Real[8,3] f_3 = TRANSFORM.Math.variableFactor(variable_3, fixed_3) "Factor matrix";
  final parameter Real[1,3] f_4 = TRANSFORM.Math.variableFactor(variable_4, fixed_4) "Factor matrix";
  final parameter Real[3,1] f_5 = TRANSFORM.Math.variableFactor(variable_5, fixed_5) "Factor matrix";
  final parameter Real[4,5] f_6 = TRANSFORM.Math.variableFactor(variable_6, fixed_6) "Factor matrix";

  final parameter Boolean df_1 = Modelica.Math.Matrices.isEqual(f_1, f_1ans,10*Modelica.Constants.eps) "=true then f = f_ans";
  final parameter Boolean df_2 = Modelica.Math.Matrices.isEqual(f_2, f_2ans,10*Modelica.Constants.eps) "=true then f = f_ans";
  final parameter Boolean df_3 = Modelica.Math.Matrices.isEqual(f_3, f_3ans,10*Modelica.Constants.eps) "=true then f = f_ans";
  final parameter Boolean df_4 = Modelica.Math.Matrices.isEqual(f_4, f_4ans,10*Modelica.Constants.eps) "=true then f = f_ans";
  final parameter Boolean df_5 = Modelica.Math.Matrices.isEqual(f_5, f_5ans,10*Modelica.Constants.eps) "=true then f = f_ans";
  final parameter Boolean df_6 = Modelica.Math.Matrices.isEqual(f_6, f_6ans,10*Modelica.Constants.eps) "=true then f = f_ans";

  annotation (experiment(StopTime=10),__Dymola_experimentSetupOutput);
end variableFactor;
