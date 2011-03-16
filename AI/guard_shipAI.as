package AI 
{
	import AI.State.AttackState;
	import AI.State.GuardPositionState;
	import AI.State.InactivityState;
	import AI.State.MoveToPositionState;
	import AI.State.PursueState;
	import AI.State.ShortPursueState;
	import AI.Transition.ReachedTransition;
	import AI.Transition.TimeoutTransition;
	import Enemies.guard_ship;
	import flash.geom.Point;
	import GameObjects.*;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public class guard_shipAI extends BaseAI
	{
		public var tactical_position: Point;
		
		public function guard_shipAI(self: guard_ship, target: GameObject, transport: ControllableObject, left_or_right: int) : void
		{
			// init AI
			//@TMP Просто для проверки оружия, надо поправить
			
			// Данные :
			// 1) Тактическая позиция - справа или слева от транспортника <= позиция транспортника
			// Алгоритм ИИ:
			// 1) Выбор тактической позиции (справа или слева от транспортника)
			// 2) Перемещение к тактической позиции
			// 3) Если замечен танк, то перемещение к врагу
			// 4) Если враг попал в область поражения, то атаковать
			// 5) Если враг вышел из области поражения, то п.2
			
			// Состояния
			tactical_position = new Point(self.x, self.y);
			var findPositionState: GuardPositionState = new GuardPositionState(tactical_position, transport, left_or_right);
			var approachPositionState: MoveToPositionState = new MoveToPositionState(self, tactical_position);
			var approachEnemyState: ShortPursueState = new ShortPursueState(self, target, tactical_position); approachEnemyState.pursueDistance = 150;
			var attackState: AttackState = new AttackState(self);
			
			// Переходы
			var transportCanSeeTransition: ReachedTransition = new ReachedTransition(transport, target, 150);
			var transportCanNotSeeTransition: ReachedTransition = new ReachedTransition(transport, target, 150);
			var canShootTransition: ReachedTransition = new ReachedTransition(self, target, 50);
			var canNotShootTransition: ReachedTransition = new ReachedTransition(self, target, 50);
			
			// Связка графа
			findPositionState.nextState = approachPositionState;
			approachPositionState.transitions = new Array(transportCanSeeTransition);
			transportCanSeeTransition.nextTrueState = approachEnemyState;
			approachEnemyState.transitions = new Array(canShootTransition, transportCanNotSeeTransition);
			canShootTransition.nextTrueState = attackState;
			transportCanNotSeeTransition.nextFalseState = approachPositionState;
			attackState.transitions = new Array(canNotShootTransition);
			canNotShootTransition.nextFalseState = approachPositionState;
			
			fsm = new FSM.FSM(findPositionState);
		}
	}
}